return {
	"catppuccin/nvim",
	name = "catppuccin",
	tag = "stable",
	lazy = true,
	priority = 1000,
	---@type CatppuccinOptions
	opts = {
		auto_integrations = true,
		custom_highlights = function(colors)
			return {
				WinSeparator = { fg = colors.mantle },
			}
		end,
	},
}
