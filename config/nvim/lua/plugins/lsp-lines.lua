return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",

	init = function()
		require("which-key").add({
			{ "<leader>l", group = "LSP" },
			{ "<leader>ll", require("lsp_lines").toggle, desc = "Toggle LSP Lines", mode = "n" },
		})
	end,
}
