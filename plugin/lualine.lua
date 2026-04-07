vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })
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
