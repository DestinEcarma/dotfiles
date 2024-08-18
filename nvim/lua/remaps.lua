vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

vim.keymap.set("n", "<C-S>", ":w<CR>")
vim.keymap.set("n", "<C-Q>", ":q<CR>", { noremap = true })

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n", "<C-\\>", ":vsplit<CR>")

vim.keymap.set("n", "<C-T>n", ":tabnew<CR>")
vim.keymap.set("n", "<C-T>l", ":tabnext<CR>")
vim.keymap.set("n", "<C-T>h", ":tabprevious<CR>")
