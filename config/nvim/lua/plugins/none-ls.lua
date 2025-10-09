return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				formatting.stylua,
				formatting.prettierd,
				formatting.clang_format,
				formatting.asmfmt,
				formatting.black.with({
					extra_args = { "--line-length", "79" },
				}),
				formatting.isort,
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
