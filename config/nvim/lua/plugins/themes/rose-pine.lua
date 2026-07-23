return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = true,
	priority = 1000,
	---@module "rose-pine"
	---@type Options
	opts = {
		highlight_groups = {
			WinBar = { bg = "base", fg = "text", cterm = { bold = true } },
			WinBarNc = { bg = "base", fg = "text", cterm = { bold = true } },
		},
	},
}
