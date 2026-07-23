return {
	"Mofiqul/dracula.nvim",
	lazy = true,
	priority = 1000,
	---@module "dracula"
	---@type DraculaConfig
	opts = {
		overrides = function(colors)
			vim.api.nvim_set_hl(0, "Visual", { bg = "#4C566A", blend = 20 })
			return {
				WinBar = { bg = colors.bg, fg = colors.fg, cterm = { bold = true } },
				WinBarNc = { bg = colors.bg, fg = colors.fg, cterm = { bold = true } },
				NormalFloat = { bg = colors.menu, fg = colors.fg },
				FloatBorder = { bg = colors.menu },
				SnacksPickerBorder = { bg = colors.menu, fg = colors.comment },
				SnacksPickerTitle = { bg = colors.menu, fg = colors.cyan, bold = true, cterm = { bold = true } },

				-- HACK: Somehow picker's title/lable does not use SnacksPickerTitle
				Title = { bg = colors.menu, fg = colors.cyan },
				SnacksDashboardTitle = { bg = colors.bg, fg = colors.cyan },
			}
		end,
	},
}
