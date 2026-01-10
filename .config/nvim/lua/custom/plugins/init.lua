-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require 'custom.plugins.nvimtree',
  -- require 'custom.plugins.toggle-lsp',
  -- fix in future
  vim.keymap.set('n', '<Leader>c', function()
    vim.lsp.stop_client(vim.lsp.get_clients())
  end),
}
