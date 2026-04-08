vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
local opt = vim.opt

opt.undofile = true
opt.list = true

opt.ignorecase = true
opt.smartcase = true

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
opt.updatetime = 50

local map = vim.keymap.set
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { timeout = 50 }
  end,
})

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

require('configs.lsp')
-- vim: ts=2 sts=2 sw=2 et
