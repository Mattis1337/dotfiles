hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccddee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		layout = "master",

		allow_tearing = true,
	},

	decoration = {
		rounding = 10,

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			ignore_opacity = true,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		mfact = 0.5,
	},

	misc = {
		force_default_wallpaper = -1,
	},
})
