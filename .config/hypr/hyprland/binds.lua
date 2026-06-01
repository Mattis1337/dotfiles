require("hyprland.variables")

-- Hyprland
-- TODO: exiting hyprland does not really work; Add a graceful logout/exit from hyprland
-- hl.bind("SUPER + CONTROL + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind("SUPER + CONTROL + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Applications
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + Q", hl.dsp.exec_cmd("hyprctl kill"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

-- Volume and media control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Screen locking
hl.bind("SUPER + PAUSE", hl.dsp.exec_cmd("swaylock -f -c 000000"))

-- Windows
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Focus
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))

-- Position
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))

-- Switch workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT +" .. key, hl.dsp.window.move({ workspace = i }))
end

-- Resize using mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
