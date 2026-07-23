-- LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspBuffer", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

		local map = function(mode, lhs, rhs, desc, others)
			local opts = vim.tbl_extend("force", {
				buffer = buf,
				desc = desc,
			}, others or {})

			vim.keymap.set(mode, lhs, rhs, opts)
		end

        -- LSP keymaps
        -- stylua: ignore start
        map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
        map("n", "gr", function() Snacks.picker.lsp_references() end, "References", { nowait = true })
        map("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
        map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
        map("n", "gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("n", "<leader>cl", function() Snacks.picker.lsp_config() end, "Lsp Info")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>ih", function() Snacks.toggle.inlay_hints():toggle() end, "Display Inlay Hints")
        map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
		-- stylua: ignore end

		-- Codelens
		if client:supports_method("textDocument/codeLens") then
			local function codeLens()
				local enabled = vim.lsp.codelens.is_enabled({ bufnr = buf })
				vim.lsp.codelens.enable(not enabled, { bufnr = buf })
			end

			map("n", "<leader>cC", codeLens, "Display Codelens")
			map({ "n", "x" }, "<leader>cc", codeLens, "Run Codelens")
		end

		-- Navic (breadcrumbs)
		if client:supports_method("textDocument/documentSymbol") then
			require("nvim-navic").attach(client, buf)
			vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
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

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("VerticalHelp", { clear = true }),
	pattern = "help",
	command = "wincmd L",
})

-- Return to last position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("ReturnLastPosition", { clear = true }),
	callback = function(ev)
		if vim.o.diff then
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local last_line = vim.api.nvim_buf_line_count(ev.buf)

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

-- Save quickfix files (For quicker.nvim)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("SaveQuickfix", { clear = true }),
	pattern = "qf",
	callback = function(ev)
		vim.keymap.set("n", "<C-s>", "<cmd>update<cr>", { desc = "Save", buf = ev.buf, noremap = true })
	end,
})

--- Lsp Progress
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("LspProgressNotify", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

-- Mark system and dependency files as unlisted scratch buffers
vim.api.nvim_create_autocmd({ "BufAdd", "BufReadPost" }, {
	pattern = { "*/node_modules/*", "/usr/share/nvim/*", "*/.local/share/nvim/*" },
	callback = function(args)
		vim.bo[args.buf].buflisted = false
	end,
})
