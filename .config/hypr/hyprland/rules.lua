-- Auto-Lock
hl.window_rule({
	name = "al-firefox",
	match = { initial_title = "Mozilla Firefox" },
	idle_inhibit = "fullscreen",
})
hl.window_rule({
	name = "al-celluloid",
	match = { class = "io.github.celluloid_player.Celluloid" },
	idle_inhibit = "fullscreen",
})
hl.window_rule({
	name = "al-discord",
	match = { class = "com.discordapp.Discord" },
	idle_inhibit = "fullscreen",
})

-- Auto-Float
hl.window_rule({
	name = "af-iwgtk",
	match = { title = "iwgtk" },
	float = true,
})
hl.window_rule({
	name = "af-pavucontrol",
	match = { class = "pavucontrol" },
	float = true,
})
hl.window_rule({
	name = "af-nwg-look",
	match = { class = "nwg-look" },
	float = true,
})
hl.window_rule({
	name = "af-tor-browser",
	match = { title = "Tor Browser" },
	float = true,
})

-- Blur
hl.window_rule({
	name = "bl-kitty",
	match = { class = "kitty" },
	opacity = "0.8 0.8",
})
hl.window_rule({
	name = "bl-discord",
	match = { class = "Discord" },
	opacity = "0.8 0.8",
})
