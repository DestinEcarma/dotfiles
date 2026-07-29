vim.api.nvim_create_user_command("ToCamelCase", function()
	local word = vim.fn.expand("<cword>")
	if word == "" then return end

	local parts = word:gsub("(%l)(%u)", "%1_%2"):gsub("(%u)(%u%l)", "%1_%2"):gsub("[%s%-]+", "_"):lower()

	local camel = parts:gsub("_(%l)", string.upper)

	vim.cmd(string.format("normal! ciw%s", camel))
end, { desc = "Convert word under cursor to camelCase" })

vim.api.nvim_create_user_command("ToPascalCase", function()
	local word = vim.fn.expand("<cword>")
	if word == "" then return end

	local parts = word:gsub("(%l)(%u)", "%1_%2"):gsub("(%u)(%u%l)", "%1_%2"):gsub("[%s%-]+", "_"):lower()

	local pascal = parts:gsub("(^%l)", string.upper):gsub("_(%l)", string.upper):gsub("_", "")

	vim.cmd(string.format("normal! ciw%s", pascal))
end, { desc = "Convert word under cursor to PascalCase" })

vim.api.nvim_create_user_command("ToSnakeCase", function()
	local word = vim.fn.expand("<cword>")
	if word == "" then return end

	local snake = word:gsub("(%l)(%u)", "%1_%2"):gsub("(%u)(%u%l)", "%1_%2"):gsub("[%s%-]+", "_"):lower()

	vim.cmd(string.format("normal! ciw%s", snake))
end, { desc = "Convert word under cursor to snake_case" })
