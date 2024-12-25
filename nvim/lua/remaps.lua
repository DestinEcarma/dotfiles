-- Leader

-- Utils
vim.keymap.set("n", "<C-S>", ":w<CR>")
vim.keymap.set("n", "<C-Q>", ":q<CR>", { noremap = true })

-- Resize Window
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Split Window
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>")
vim.keymap.set("n", "<A-\\>", ":split<CR>")
vim.keymap.set("n", "«", ":split<CR>")

-- Tab Window
vim.keymap.set("n", "<C-T>n", ":tabnew<CR>")
vim.keymap.set("n", "<C-T>l", ":tabnext<CR>")
vim.keymap.set("n", "<C-T>h", ":tabprevious<CR>")

-- Move Line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "∆", ":m .+1<CR>==")
vim.keymap.set("n", "˚", ":m .-2<CR>==")
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv")

-- Select Allow
vim.keymap.set("n", "<C-A>", "ggVG")
