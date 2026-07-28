local M = {}

M.opts = {
	terminal = {
		auto_insert = true,
		cmd = vim.o.shell,
	},
	float = {
		anchor = "NW",
		border = "rounded",
		style = "minimal",
		zindex = 50,
		backdrop = 60,
	},
	winbar = {
		separator = {
			left = "",
			right = "",
		},
	},
	colors = {
		window = "#1e1e2e",
		border = "#89b4fa",
		tab_active = "#1e1e2e",
		tab_inactive = "#171724",
		tab_fill = "#11111b",
		text_active = "#cdd6f4",
		text_inactive = "#494C5D",
	},
}

-- stylua: ignore
function M.setup(opts)
    M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

return M
