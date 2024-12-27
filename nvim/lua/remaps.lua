local merge_tables = require("utils.merge-tables")

local opts = { silent = true, noremap = true }

-- Utils
vim.keymap.set("n", "<C-S>", "<cmd>w<CR>", merge_tables(opts, { desc = "Save" }))
vim.keymap.set("n", "<C-Q>", "<cmd>q<CR>", merge_tables(opts, { desc = "Quit" }))

-- Resize Window
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", merge_tables(opts, { desc = "Resize Window Up" }))
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", merge_tables(opts, { desc = "Resize Window Down" }))
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", merge_tables(opts, { desc = "Resize Window Left" }))
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", merge_tables(opts, { desc = "Resize Window Right" }))

-- Split Window
vim.keymap.set("n", "<C-\\>", "<cmd>vsplit<CR>", merge_tables(opts, { desc = "Split Window Virtically" }))
vim.keymap.set("n", "<A-\\>", "<cmd>split<CR>", merge_tables(opts, { desc = "Split Window Horizontally" }))
vim.keymap.set("n", "«", "<cmd>split<CR>", merge_tables(opts, { desc = "Split Window Horizontally" }))

-- Tab Window
vim.keymap.set("n", "<C-T>n", "<cmd>tabnew<CR>", merge_tables(opts, { desc = "New Tab" }))
vim.keymap.set("n", "<C-T>l", "<cmd>tabnext<CR>", merge_tables(opts, { desc = "Next Tab" }))
vim.keymap.set("n", "<C-T>h", "<cmd>tabprevious<CR>", merge_tables(opts, { desc = "Previous Tab" }))

-- Move Line
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("v", "<A-k>", "<cmd>'<,'>m '<-2' <CR>gv=gv", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("v", "<A-j>", "<cmd>'<,'>m '>+1' <CR>gv=gv", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("n", "∆", "<cmd>m .+1<CR>==", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("n", "˚", "<cmd>m .-2<CR>==", merge_tables(opts, { desc = "Move Line Up" }))
vim.keymap.set("v", "∆", "<cmd>'<,'>m '>+1' <CR>gv=gv", merge_tables(opts, { desc = "Move Line Down" }))
vim.keymap.set("v", "˚", "<cmd>'<,'>m '<-2<CR>gv=gv", merge_tables(opts, { desc = "Move Line Up" }))

-- Select Allow
vim.keymap.set("n", "<C-A>", "ggVG", merge_tables(opts, { desc = "Select All" }))
