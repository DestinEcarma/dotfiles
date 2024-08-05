return {
	"lewis6991/gitsigns.nvim",

	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local opts = { buffer = bufnr }

				vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)
				vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
				vim.keymap.set("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, opts)
			end,
		})
	end,
}
