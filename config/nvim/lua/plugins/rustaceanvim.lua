return {
	"mrcjkb/rustaceanvim",
	version = "^5.20.1",
	lazy = false,

	config = function()
		vim.g.rustaceanvim = {
			tools = {
				float_win_config = { border = "rounded" },
			},
			server = {
				on_attach = function(client, bufnr)
					require("lsp-options").on_attach(client, bufnr)

					local hover_actions = "<cmd>RustLsp hover actions<CR>"
					local diagnostics = "<cmd>RustLsp renderDiagnostic<CR>"
					local code_actions = "<cmd>RustLsp codeAction<CR>"

					require("which-key").add({
						mode = { "n" },
						{ "K", hover_actions, desc = "Display Documentation" },
						{ "<leader>e", diagnostics, desc = "Display Line Diagnostics" },
						{ "<leader>ca", code_actions, desc = "Code Actions" },

						{ "<leader>l", group = "LSP" },
						{ "<leader>lK", hover_actions, desc = "Display Documentation" },
						{ "<leader>le", diagnostics, desc = "Display Line Diagnostics" },
						{ "<leader>lca", code_actions, desc = "Code Actions" },
						{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },
					})

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
						end,
					})
				end,
			},
		}
	end,
}
