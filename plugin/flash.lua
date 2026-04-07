vim.pack.add({ 'https://github.com/folke/flash.nvim' })

local map = vim.keymap.set

map({ "n", "x", "o" }, "<leader>n", function()
    require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "<leader>/", function()
    require("flash").jump({
        search = { mode = "search", max_length = 0 },
        label = { after = { 0, 0 } },
        pattern = "^"
    })
end, { desc = "Line Jumper" })
