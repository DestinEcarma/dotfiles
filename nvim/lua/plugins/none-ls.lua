return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.asmfmt,
			},

			on_attach = function(client, bufner)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufner,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufner, id = client.id })
					end,
				})
			end,
		})

		vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, { desc = "Format" })
	end,
}
