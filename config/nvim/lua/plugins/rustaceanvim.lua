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
					local builtin = require("telescope.builtin")

					local hover_actions = "<cmd>RustLsp hover actions<CR>"
					local diagnostics = "<cmd>RustLsp renderDiagnostic<CR>"
					local code_actions = "<cmd>RustLsp codeAction<CR>"

					require("which-key").add({
						mode = { "n" },
						{ "K", hover_actions, desc = "Display Documentation" },
						{ "<leader>e", diagnostics, desc = "Display Line Diagnostics" },
						{ "<leader>ca", code_actions, desc = "Code Actions" },
						{ "<leader>ra", vim.lsp.buf.rename, desc = "Rename" },

						{ "<leader>l", group = "LSP" },
						{ "<leader>ll", require("lsp_lines").toggle, desc = "Toggle LSP Lines" },
						{ "<leader>lK", hover_actions, desc = "Display Documentation" },
						{ "<leader>lgd", vim.lsp.buf.definition, desc = "Go to Definition" },
						{ "<leader>le", diagnostics, desc = "Display Line Diagnostics" },
						{ "<leader>lra", vim.lsp.buf.rename, desc = "Rename" },
						{ "<leader>lca", code_actions, desc = "Code Actions" },
						{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },

						{ "<leader>fr", builtin.lsp_references, desc = "Telescope LSP References" },
						{ "<leader>fd", builtin.diagnostics, desc = "Telescope LSP Diagnostics" },
						{ "<leader>fq", builtin.quickfix, desc = "Telescope LSP Quickfix" },
					})

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
				end,
			},
		}
	end,
}
