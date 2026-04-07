vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' })
require('telescope').setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require('telescope.builtin')
local map = vim.keymap.set

map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>ss', builtin.find_files, { desc = '[S]earch Files' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>b', builtin.buffers, { desc = 'Find [B]uffers' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

map('n', '<leader>s<leader>', function()
    builtin.oldfiles({ prompt_title = 'Recent Files' })
end, { desc = '[S]earch Recent Files' })

map('n', '<leader><leader>', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
        prompt_title = 'Fuzzy Flying',
    })
end, { desc = '[ ] Fuzzily search in current buffer' })

map('n', '<leader>sn', function()
    builtin.find_files({ cwd = vim.fn.stdpath('config'), prompt_title = 'Config Files' })
end, { desc = '[S]earch [N]eovim files' })
