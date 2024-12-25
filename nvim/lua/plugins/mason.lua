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

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			local lspconfig = require("lspconfig")

			local servers = {
				lua_ls = require("lsp-options.lua_ls"),
			}

			local on_attach = require("lsp-options").on_attach
			local capabilities = require("lsp-options").capabilities

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					if server_name == "rust_analyzer" then
						return
					end

					local server_config = servers[server_name] or {}

					server_config.on_attach = on_attach
					server_config.capabilities = capabilities

					lspconfig[server_name].setup(server_config)
				end,
			})
		end,
	},
}
