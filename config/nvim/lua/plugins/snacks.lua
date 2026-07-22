return {
	"folke/snacks.nvim",
	dependencies = {
		-- "nvim-mini/mini.icons"
		"nvim-tree/nvim-web-devicons",
	},
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = {
			enabled = true,
		},
		notifier = { enabled = true },
		picker = {
			sources = {
				explorer = {
					auto_close = true,
					layout = { layout = { position = "right" } },
				},
			},
		},
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
