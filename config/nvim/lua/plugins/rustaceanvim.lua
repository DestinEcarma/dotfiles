local merge_tables = require("utils.merge-tables")

local hover_actions = "<cmd>RustLsp hover actions<CR>"
local diagnostics = "<cmd>RustLsp renderDiagnostic<CR>"
local code_actions = "<cmd>RustLsp codeAction<CR>"

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

					local opts = { silent = true, noremap = true, buffer = bufnr }

					vim.keymap.set("n", "K", hover_actions, merge_tables(opts, { desc = "Display Documentation" }))
					vim.keymap.set("n", "<leader>e", diagnostics, merge_tables({ desc = "Display Line Diagnostics" }))
					vim.keymap.set("n", "<leader>ca", code_actions, merge_tables(opts, { desc = "Code Actions" }))

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
						end,
					})

					vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, { desc = "Format" })
				end,
			},
		}
	end,
}
