local lsp_options = require("lsp-options")

return {
	capabilities = lsp_options.capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
			},
		},
	},
}
