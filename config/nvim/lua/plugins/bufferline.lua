return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			highlights = require("catppuccin.special.bufferline").get_theme(),
			options = {
				mode = "tabs",
				buffer_close_icon = "",
				separator_style = "slant",
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
