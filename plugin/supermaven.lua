vim.pack.add({ 'https://github.com/supermaven-inc/supermaven-nvim' })
require('supermaven-nvim').setup({})

vim.keymap.set("n", "<leader>aa", function()
    local api = require("supermaven-nvim.api")
    if api.is_running() then
        api.stop()
    else
        api.start()
    end
end, { desc = "Toggle Supermaven" })
