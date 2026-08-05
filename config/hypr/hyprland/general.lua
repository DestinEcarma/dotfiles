hl.monitor({
	output = "",
	mode = "highrr",
	position = "auto",
	scale = 1,
})

hl.config({
	general = {
		border_size = 2,
		gaps_in = 5,
		gaps_out = 10,
		resize_on_border = true,
		no_focus_fallback = true,
		allow_tearing = true,
		snap = { enabled = true },
	},
	decoration = {
		rounding = 5,
		active_opacity = 0.9,
		inactive_opacity = 0.9,
		dim_inactive = true,
		dim_strength = 0.25,
		dim_special = 0.5,
		blur = {
			size = 15,
			passes = 2,
		},
		shadow = {
			range = 20,
			offset = { 0, 2 },
			render_power = 10,
			color = "rgba(00000020)",
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		font_family = "CaskaydiaCove Nerd Font",
	},
	xwayland = {
		force_zero_scaling = true,
	},
	ecosystem = {
		-- I'm broke
		no_donation_nag = true,
	},
	cursor = {
		no_hardware_cursors = true,
	},
})

local success, colors = pcall(require, "hyprland.colors")

if success then
	hl.config({
		general = {
			col = {
				active_border = colors.primary,
				inactive_border = colors.background,
			},
		},
	})
end
