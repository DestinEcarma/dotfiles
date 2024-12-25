local merge_tables = require("utils.merge-tables")

local opts = { silent = true, noremap = true }

-- Utils
vim.keymap.set("n", "<C-S>", ":w<CR>", merge_tables(opts, { desc = "Save" }))
vim.keymap.set("n", "<C-Q>", ":q<CR>", merge_tables(opts, { desc = "Quit" }))

-- Resize Window
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", merge_tables(opts, { desc = "Resize Window Up" }))
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", merge_tables(opts, { desc = "Resize Window Down" }))
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", merge_tables(opts, { desc = "Resize Window Left" }))
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", merge_tables(opts, { desc = "Resize Window Right" }))

-- Split Window
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", merge_tables(opts, { desc = "Split Window Virtically" }))
vim.keymap.set("n", "<A-\\>", ":split<CR>", merge_tables(opts, { desc = "Split Window Horizontally" }))
vim.keymap.set("n", "«", ":split<CR>", merge_tables(opts, { desc = "Split Window Horizontally" }))

-- Tab Window
vim.keymap.set("n", "<C-T>n", ":tabnew<CR>", merge_tables(opts, { desc = "New Tab" }))
vim.keymap.set("n", "<C-T>l", ":tabnext<CR>", merge_tables(opts, { desc = "Next Tab" }))
vim.keymap.set("n", "<C-T>h", ":tabprevious<CR>", merge_tables(opts, { desc = "Previous Tab" }))

-- Move Line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("n", "∆", ":m .+1<CR>==", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("n", "˚", ":m .-2<CR>==", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", merge_tables(opts, { desc = "Move Line Up" }))

-- Select Allow
vim.keymap.set("n", "<C-A>", "ggVG", merge_tables(opts, { desc = "Select All" }))
