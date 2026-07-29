return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			preview = { enable = false },
			markdown = {
				block_quotes = presets.block_quotes.obsidian,
			},
		})
	end,
}
