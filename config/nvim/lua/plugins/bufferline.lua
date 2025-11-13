return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "tabs",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo Tree",
						text_align = "center",
						separator = true,
					},
				},
			},
		})
	end,
}
