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
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.asmfmt,
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "79" },
				}),
				null_ls.builtins.formatting.isort,
			},

			on_attach = function(client, bufnr)
				if
					not client:supports_method("textDocument/willSaveWaitUntil")
					and client:supports_method("textDocument/formatting")
				then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
						end,
					})
				end

				require("which-key").add({
					{ "<leader>lf", vim.lsp.buf.format, desc = "Format", mode = { "n" } },
				})
			end,
		})
	end,
}
