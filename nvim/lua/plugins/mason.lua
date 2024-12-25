return {
	{
		"williamboman/mason.nvim",

		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,

		config = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			local function on_attach(_, bufner)
				local opts = { buffer = bufner }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)

				vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			local lspconfig = require("lspconfig")

			local servers = {
				lua_ls = require("lsp-options.lua_ls"),
			}

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_config = servers[server_name] or {}

					server_config.on_attach = on_attach
					server_config.capabilities = require("lsp-options").capabilities

					lspconfig[server_name].setup(server_config)
				end,
			})
		end,
	},
}
