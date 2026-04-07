vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
local opt = vim.opt

opt.undofile = true
opt.list = true

-- General UX
opt.showmode = false
opt.number = true
opt.relativenumber = true
opt.splitright = true
opt.splitbelow = true
opt.mouse = 'a'
opt.termguicolors = true
opt.signcolumn = "yes"
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true
opt.shiftwidth = 4
opt.expandtab = true
opt.hlsearch = false
opt.timeoutlen = 50

require('configs.lsp')
-- vim: ts=2 sts=2 sw=2 et
