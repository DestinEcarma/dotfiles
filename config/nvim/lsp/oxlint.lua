return {
	cmd = function(dispatchers, config)
		local cmd = { "oxlint", "--lsp" }
		if (config or {}).root_dir then
			for _, name in ipairs({ "oxlint", "vp" }) do
				local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", name)
				if vim.fn.executable(local_cmd) == 1 then
					cmd = name == "vp" and { local_cmd, "lint", "--lsp" } or { local_cmd, "--lsp" }
					return vim.lsp.rpc.start(cmd, dispatchers)
				end
			end
		end
		if vim.fn.executable("oxlint") == 0 and vim.fn.executable("vp") == 1 then cmd = { "vp", "lint", "--lsp" } end
		return vim.lsp.rpc.start(cmd, dispatchers)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(fname, { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" })
		if root then on_dir(root) end
	end,
}
