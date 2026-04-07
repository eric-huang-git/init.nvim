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
map('n', '<leader>s<leader>', function()
    builtin.oldfiles {
        prompt_title = 'Recent files',
    }
end, { desc = '[S]earch Recent Files ("." for repeat)' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader><leader>', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
        prompt_title = 'Fuzzy Flying',
    })
end, { desc = '[ ] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'God Grep in Open Files',
    }
end, { desc = '[S]earch [/] in Open Files' })

map('n', '<leader>sn', function()
    builtin.find_files {
        prompt_title = 'Find Neovim Files',
        cwd = vim.fn.stdpath 'config',
    }
end, { desc = '[S]earch [N]eovim files' })

map('n', '<leader>sg', function()
    builtin.live_grep {
        prompt_title = 'God Grep',
    }
end, { desc = '[S]earch by [G]rep' })

map('n', '<leader>sc', function()
    builtin.find_files {
        prompt_title = 'Find Config Files',
        cwd = '~/.config',
    }
end, { desc = '[S]earch [C]onfig files' })
