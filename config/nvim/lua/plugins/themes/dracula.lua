return {
	"Mofiqul/dracula.nvim",
	lazy = true,
	priority = 1000,
	---@module "dracula"
	---@type DraculaConfig
	opts = {
		overrides = function(colors)
			return {
				WinBar = { link = "Normal", cterm = { bold = true } },
				WinBarNc = { link = "Normal", cterm = { bold = true } },

				NormalFloat = { bg = colors.menu, fg = colors.fg },
				FloatBorder = { bg = colors.menu },
				FloatTitle = { bg = colors.menu, fg = colors.cyan },

				SnacksPickerBorder = { bg = colors.menu, fg = colors.comment },
				SnacksPickerTitle = { bg = colors.menu, fg = colors.cyan, bold = true, cterm = { bold = true } },

				-- TODO: Fix the color of bufferline.
			}
		end,
	},
}
