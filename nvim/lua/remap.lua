vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded'
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.cursorline = true

vim.opt.mouse = "a"

local keymap = vim.keymap.set
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
