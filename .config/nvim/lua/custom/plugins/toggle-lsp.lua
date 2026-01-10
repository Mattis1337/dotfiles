-- Initialize a flag to toggle LSPs on or off
local lsp_enabled = true
-- Store buffers attached to each LSP client
local attached_buffers_by_client = {}
-- Store configurations for each LSP client
local client_configs = {}

-- Store a reference to the original buf_attach_client function
local original_buf_attach_client = vim.lsp.buf_attach_client

-- Function to add a buffer to the client's buffer table
local function add_buf(client_id, buf)
  if not attached_buffers_by_client[client_id] then
    attached_buffers_by_client[client_id] = {}
  end

  -- Check if the buffer is already in the list
  local exists = false
  for _, value in ipairs(attached_buffers_by_client[client_id]) do
    if value == buf then
      exists = true
      break
    end
  end

  -- Add the buffer if it doesn’t already exist in the client’s list
  if not exists then
    table.insert(attached_buffers_by_client[client_id], buf)
  end
end

-- Middleware function to control LSP client attachment to buffers
-- Prevents LSP client from reattaching if LSPs are disabled
vim.lsp.buf_attach_client = function(bufnr, client_id)
  if not lsp_enabled then
    -- Cache client configuration if not already stored
    if not client_configs[client_id] then
      local client_config = vim.lsp.get_client_by_id(client_id)
      client_configs[client_id] = (client_config and client_config.config) or {}
    end

    -- Add buffer to client’s attached buffer list and stop the client
    add_buf(client_id, bufnr)
    vim.lsp.stop_client(client_id)

    return false -- Indicate the client should not attach
  end
  return original_buf_attach_client(bufnr, client_id) -- Use the original attachment method if enabled LSP
end

-- Update state with new client IDs after a toggle
local function update_clients_ids(ids_map)
  local new_attached_buffers_by_client = {}
  local new_client_configs = {}

  -- Map each client ID to its new ID and carry over configurations
  for client_id, buffers in pairs(attached_buffers_by_client) do
    local new_id = ids_map[client_id]
    new_attached_buffers_by_client[new_id] = buffers
    new_client_configs[new_id] = client_configs[client_id]
  end

  attached_buffers_by_client = new_attached_buffers_by_client -- Update global attached buffer table
  client_configs = new_client_configs -- Update global client config table
end

-- Stops the client, waiting up to 5 seconds; force quits if needed
local function client_stop(client)
  vim.lsp.stop_client(client.id, false)

  local timer = vim.uv.new_timer() -- Create a timer
  local max_attempts = 50 -- Set max attempts to check if stopped
  local attempts = 0 -- Track the number of attempts
  if timer ~= nil then
    timer:start(
      100,
      100,
      vim.schedule_wrap(function()
        attempts = attempts + 1

        if client.is_stopped() then -- Check if the client is stopped
          timer:stop()
          timer:close()
          vim.diagnostic.reset() -- Reset diagnostics for the client
        elseif attempts >= max_attempts then -- If max attempts reached
          vim.lsp.stop_client(client.id, true) -- Force stop the client
          timer:stop()
          timer:close()
          vim.diagnostic.reset() -- Reset diagnostics for the client
        end
      end)
    )
  end
end

-- Toggle LSPs on or off, managing client states and attached buffers
local function toggle_lsp()
  if lsp_enabled then -- If LSP is currently enabled, disable it
    client_configs = {} -- Clear client configurations
    attached_buffers_by_client = {} -- Clear attached buffers

    -- Loop through all active LSP clients
    for _, client in ipairs(vim.lsp.get_clients()) do
      client_configs[client.id] = client.config -- Cache client config

      -- Loop through all buffers attached to the client
      for buf, _ in pairs(client.attached_buffers) do
        add_buf(client.id, buf) -- Add buffer to the client’s buffer table
        vim.lsp.buf_detach_client(buf, client.id) -- Detach the client from the buffer
      end

      client_stop(client) -- Stop the client
    end

    print 'LSPs Disabled'
  else -- If LSP is currently disabled, enable it
    local new_ids = {}

    -- Reinitialize clients with previous configurations
    for client_id, buffers in pairs(attached_buffers_by_client) do
      local client_config = client_configs[client_id] -- Retrieve client config
      local new_client_id, err = vim.lsp.start(client_config) -- Start client with config

      new_ids[client_id] = new_client_id -- Map old client ID to new client ID

      if err then -- Notify if there was an error starting the client
        vim.notify(err, vim.log.levels.WARN)
        return nil
      end

      -- Reattach buffers to the newly started client
      for _, buf in ipairs(buffers) do
        original_buf_attach_client(buf, new_client_id)
      end
    end

    update_clients_ids(new_ids) -- Update client IDs
    print 'LSPs Enabled' -- Notify that LSPs are enabled
  end

  lsp_enabled = not lsp_enabled -- Toggle the LSP enabled flag
end

-- Set key mapping to toggle LSP on or off with <leader>tl
vim.keymap.set('n', '<leader>tl', toggle_lsp)
