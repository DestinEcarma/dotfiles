local merge_tables = require("utils.merge-tables")

return {
	"mrcjkb/rustaceanvim",
	version = "^5.20.1",
	lazy = false,

	config = function()
		vim.g.rustaceanvim = {
			tools = {
				hover_actions = {
					border = "rounded",
				},
			},

			server = {
				on_attach = function(client, bufnr)
					require("lsp-options").on_attach(client, bufnr)

					local opts = { silent = true, noremap = true, buffer = bufnr }

					local function hover_actions()
						vim.cmd.RustLsp({ "hover", "actions" })
					end

					local function code_actions()
						vim.cmd.RustLsp("codeAction")
					end

					vim.keymap.set("n", "K", hover_actions, merge_tables(opts, { desc = "Display Documentation" }))
					vim.keymap.set("n", "<leader>ca", code_actions, merge_tables(opts, { desc = "Code Actions" }))

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
						end,
					})
				end,

				default_settings = {
					["rust-analyzer"] = {
						capabilites = require("lsp-options").capabilities,
					},
				},
			},
		}
	end,
}
