vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

local map = vim.keymap.set

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open Oil' })
map('n', '<leader>tc', '<cmd>Oil ~/.config<cr>', { desc = 'Oil to Config' })
map('n', '<leader>th', '<cmd>Oil ~<cr>', { desc = 'Oil to Home' })
map('n', '<leader>td', '<cmd>Oil ~/Downloads<cr>', { desc = 'Oil to Downloads' })
map('n', '<leader>tt', ':Oil ', { silent = false, desc = 'Oil to Custom Path' })
