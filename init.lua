require('tokyonight').setup({
  style = "night",
  styles = {
    comments = { italic = false },
  },
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd.colorscheme 'tokyonight-night'

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

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

require('lualine').setup {
  options = {
    theme = 'tokyonight', -- Syncs with your colorscheme
    component_separators = '|',
    section_separators = { left = '', right = '' },
    globalstatus = true, -- 0.13 standard: one bar for all splits
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename' },
    lualine_x = {
      -- Custom Supermaven Indicator
      {
        function()
          return require("supermaven-nvim.api").is_running() and "󰚩 " or "󰌌 "
        end,
        color = { fg = '#ff9e64' },
      },
      'diagnostics',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
  },
}

require("which-key").setup({
  preset = "helix",
  delay = 0
})

require("configs.startup")
require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}
require("supermaven-nvim").setup({})

-- Load extensions
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
require("keymaps")
-- vim: ts=2 sts=2 sw=2 et
