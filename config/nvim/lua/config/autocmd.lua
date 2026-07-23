-- Keymap helper
local map = vim.keymap.set

-- LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspBuffer", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

        -- LSP keymaps
        -- stylua: ignore start
        map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition", buf = buf })
        map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", buf = buf, nowait = true })
        map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation", buf = buf })
        map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition", buf = buf })
        map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration", buf = buf })
        map("n", "ge", vim.diagnostic.open_float, { desc = "Open Line Diagnostic", buf = buf })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buf = buf })
        map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buf = buf })
        map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buf = buf })
        map("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "Lsp Info", buf = buf })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buf = buf })
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buf = buf })
        map("n", "<leader>ih", function() Snacks.toggle.inlay_hints() end, { desc = "Display Inlay Hints", buf = buf })
        map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols", buf = buf })
		-- stylua: ignore end

		-- Codelens
		if client:supports_method("textDocument/codeLens") then
			local function codeLens()
				local enabled = vim.lsp.codelens.is_enabled({ bufnr = buf })
				vim.lsp.codelens.enable(not enabled, { bufnr = buf })
			end

			map("n", "<leader>cC", codeLens, { desc = "Display Codelens", buf = buf })
			map({ "n", "x" }, "<leader>cc", codeLens, { desc = "Run Codelens", buf = buf })
		end

		-- Navic (breadcrumbs)
		if client:supports_method("textDocument/documentSymbol") then
			require("nvim-navic").attach(client, buf)
			vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- LazyFile event trigger
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("LazyFile", { clear = true }),
	callback = function()
		vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
	end,
})

-- Return to last position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("ReturnLastPosition", { clear = true }),
	callback = function()
		if vim.o.diff then
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"')
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		if pcall(vim.api.nvim_win_set_cursor, 0, last_pos) then
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- Wrap, linebreak, and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("MarkdownTextFile", { clear = true }),
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- Disable comment continuation for o key
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NoComment", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove("o")
	end,
})
