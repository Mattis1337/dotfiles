-- System
hl.monitor({
	output = "DP-2",
	mode = "2560x1440@240",
	position = "0x0",
	scale = 1.07,
})
hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@60",
	position = "-1920x200",
	scale = 1,
})

hl.config({
	input = {
		kb_layout = "de",

		follow_mouse = 2,
		accel_profile = "flat",

		scroll_method = "on_button_down",
		scroll_button = 274, -- mouse:274

		sensitivity = -0.2,
	},

	misc = {
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		force_default_wallpaper = -1,
		disable_autoreload = true,
		focus_on_activate = false,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
