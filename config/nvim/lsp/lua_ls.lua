return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".git", ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "selene.toml", "selene.yml" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				pathStrict = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
}
