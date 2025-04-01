return {
	"folke/which-key.nvim",
	event = "VeryLazy",

	dependencies = {
		"echasnovski/mini.nvim",
	},

	config = function()
		require("which-key").setup({
			win = {
				border = "rounded",
			},
		})
	end,
}
