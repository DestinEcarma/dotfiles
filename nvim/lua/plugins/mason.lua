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
			local lspconfig = require("lspconfig")

			local servers = {
				lua_ls = require("lsp-options.lua_ls"),
				remark_ls = require("lsp-options.remark_ls"),
			}

			local handlers = require("lsp-options").handlers
			local on_attach = require("lsp-options").on_attach
			local capabilities = require("lsp-options").capabilities

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					if server_name == "rust_analyzer" then
						return
					end

					local server_config = servers[server_name] or {}

					server_config.handlers = handlers
					server_config.on_attach = on_attach
					server_config.capabilities = capabilities

					lspconfig[server_name].setup(server_config)
				end,
			})
		end,
	},
}
