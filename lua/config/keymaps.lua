-- File Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })  -- Open file explorer (netrw)

-- Paste over selection without yanking
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste over selection (keep clipboard)" })

-- System clipboard yank
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard (normal)" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard (visual)" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank entire line to system clipboard" })

-- Tmux integration
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww goto<CR>", { desc = "Open tmux window and run `goto`" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
