local builtin = require('telescope.builtin')
local map = vim.keymap.set

-- Oil Keybindings
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open Oil' })
map('n', '<leader>tc', '<cmd>Oil ~/.config<cr>', { desc = 'Oil to Config' })
map('n', '<leader>th', '<cmd>Oil ~<cr>', { desc = 'Oil to Home' })
map('n', '<leader>td', '<cmd>Oil ~/Downloads<cr>', { desc = 'Oil to Downloads' })
map('n', '<leader>tt', ':Oil ', { silent = false, desc = 'Oil to Custom Path' })

-- telescope
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>ss', builtin.find_files, { desc = '[S]earch Files' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>b',  builtin.buffers,     { desc = 'Find [B]uffers' })
map('n', '<leader>sg', builtin.live_grep,   { desc = '[S]earch by [G]rep' })

-- Recent Files
map('n', '<leader>s<leader>', function()
  builtin.oldfiles({ prompt_title = 'Recent Files' })
end, { desc = '[S]earch Recent Files' })

-- Current Buffer Fuzzy Search
map('n', '<leader><leader>', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
    prompt_title = 'Fuzzy Flying',
  })
end, { desc = '[ ] Fuzzily search in current buffer' })

-- Specialized Searches
map('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config'), prompt_title = 'Config Files' })
end, { desc = '[S]earch [N]eovim files' })


-- SuperMaven
map("n", "<leader>aa", function()
  local api = require("supermaven-nvim.api")
  if api.is_running() then
    api.stop()
  else
    api.start()
  end
end, { desc = "Toggle Supermaven" })
-- Flash
map({"n", "x", "o"}, "<leader>n", function()
  require("flash").jump()
end, { desc = "Flash" })

map({"n", "x", "o"}, "<leader>/", function()
    require("flash").jump({
    search = { mode = "search", max_length = 0 },
    label = { after = { 0, 0 } },
    pattern = "^"
}) end, { desc = "Line Jumper" })
