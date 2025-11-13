return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			integrations = {
				navic = {
					enabled = true,
					custom_bg = "NONE",
				},
			},
		})

		vim.cmd([[colorscheme catppuccin]])

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
