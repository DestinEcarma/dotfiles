return {
	"lewis6991/gitsigns.nvim",

	config = function()
		require("gitsigns").setup({
			on_attach = function(_)
				local gitsigns = require("gitsigns")

				local function blame_line()
					gitsigns.blame_line({ full = true })
				end

				require("which-key").add({
					mode = { "n" },
					{ "<leader>g", group = "Git" },
					{ "<leader>gh", gitsigns.preview_hunk, desc = "Preview hunk" },
					{ "<leader>gtb", gitsigns.toggle_current_line_blame, desc = "Toggle blame" },
					{ "<leader>gb", blame_line, desc = "Blame line" },
				})
			end,
		})
	end,
}
