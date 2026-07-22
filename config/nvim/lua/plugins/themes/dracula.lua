return {
	"Mofiqul/dracula.nvim",
	lazy = true,
	priority = 1000,
	---@type DraculaConfig
	config = function()
		require("dracula").setup({
			overrides = function(colors)
				return {
					WhichKeyNormal = { bg = colors.menu, fg = colors.fg },
					NoicePopup = { bg = colors.menu, fg = colors.fg },
					BlinkCmpDoc = { bg = colors.menu, fg = colors.fg },
					BlinkCmpDocBorder = { bg = colors.menu, fg = colors.fg },
					BlinkCmpDocSeparator = { bg = colors.menu, fg = colors.fg },
					WinBar = { bg = colors.bg, fg = colors.fg, cterm = { bold = true } },
					WinBarNc = { bg = colors.bg, fg = colors.fg, cterm = { bold = true } },
				}
			end,
		})
	end,
}
