return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = true,
	priority = 1000,
	---@module "rose-pine"
	---@type Options
	opts = {
		highlight_groups = {
			WinBar = { link = "Normal", cterm = { bold = true } },
			WinBarNC = { link = "Normal", cterm = { bold = true } },
		},
	},
}
