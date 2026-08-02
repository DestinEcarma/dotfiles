hl.window_rule({
	match = {
		initial_class = "org.gnome.Nautilus|org.gnome.Loupe|xdg-desktop-portal-gtk",
	},
	float = true,
	center = true,
	size = { 800, 600 },
})

hl.window_rule({
	match = {
		class = "float",
	},
	float = true,
	size = { 800, 600 },
})

hl.layer_rule({
	match = {
		namespace = "waybar|swaync-control-center|swaync-notification-window|rofi|logout_dialog",
	},
	blur = true,
	dim_around = true,
	ignore_alpha = 0,
})
