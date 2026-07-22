local theme_file = vim.fn.stdpath("state") .. "/theme.txt"

local function get_saved_theme()
	local file = io.open(theme_file, "r")
	if not file then
		return "default"
	end
	local theme = file:read("*a"):gsub("%s+", "")
	file:close()
	return theme ~= "" and theme or "default"
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local theme = vim.g.colors_name
		if not theme then
			return
		end
		local file = io.open(theme_file, "w")
		if file then
			file:write(theme)
			file:close()
		end
	end,
})

vim.schedule(function()
	vim.cmd.colorscheme(get_saved_theme())
end)
