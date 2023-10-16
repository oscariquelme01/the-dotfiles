-- This file is meant to keep the keymaps for a better default neovim experience, each plugin's mappings should be set in its corresponding file

local keymap = vim.keymap.set

------- VISUAL MODE -------
-- move lines
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", {noremap = true, silent = true, desc = "move line up"})
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", {noremap = true, silent = true, desc = "move line down"})
-- indent
keymap("v", ">", ">gv", {noremap = true, silent = true, desc = "visual indent"})
keymap("v", "<", "<gv", {noremap = true, silent = true, desc = "visual indent"})

------- INSERT MODE -------
-- move lines
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", {noremap = true, silent = true, desc = "move line down"})
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", {noremap = true, silent = true, desc = "move line up"})
-- motions
keymap("i", "<C-h>", "<Left>", {desc = "move left"})
keymap("i", "<C-l>", "<Right>", {desc = "move right"})
keymap("i", "<C-j>", "<Down>", {desc = "move down"})
keymap("i", "<C-k>", "<Up>", {desc = "move up"})

------- NORMAL MODE -------
-- navigation
keymap("n", "<A-Left>", ":vertical resize +3<CR>", {noremap = true, silent = true, desc = "Resize window left"})
keymap("n", "<A-Right>", ":vertical resize -3<CR>", {noremap = true, silent = true, desc = "Resize window right"})
keymap("n", "<A-Up>", ":resize +3<CR>", {noremap = true, silent = true, desc = "Resize window up"})
keymap("n", "<A-Down>", ":resize +3<CR>", {noremap = true, silent = true, desc = "Resize window down"})
-- move lines
keymap("n", "<A-j>", ":m .+1<CR>==", {noremap = true, silent = true, desc = "move line down"})
keymap("n", "<A-k>", ":m .-2<CR>==", {noremap = true, silent = true, desc = "move line up"})
-- folds
keymap("n", "mm", ":foldopen<CR>", {noremap = true, silent = true, desc = "open fold"})
keymap("n", "mn", ":foldclose<CR>", {noremap = true, silent = true, desc = "close fold"})
-- diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- tab navigation
keymap('n', 'tn', ':tabnext<CR>', { silent = true, desc = 'Go to next tab'})
keymap('n', 'tp', ':tabprevious<CR>', { silent = true, desc = 'Go to previous tab'})
keymap('n', 'tc', ':tabclose<CR>', { silent = true, desc = 'Close tab'})
-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Buffer navigation
keymap('n', '<TAB>', ':bn<CR>', { silent = true, desc = 'go to next buffer'})
keymap('n', '<S-TAB>', ':bp<CR>', { silent = true, desc = 'go to previous buffer'})
keymap('n', '<leader>x', ':bd<CR>', { silent = true, desc = 'delete buffer'})
-- resize panes
keymap('n', '<A-Left>', ':vertical resize +3<CR>')
keymap('n', '<A-Right>', ':vertical resize -3<CR>')
keymap('n', '<A-Up>', ':resize +3<CR>')
keymap('n', '<A-Down>', ':resize -3<CR>')
