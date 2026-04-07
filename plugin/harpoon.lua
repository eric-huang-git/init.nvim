vim.pack.add({
    {
        src = 'https://github.com/ThePrimeagen/harpoon',
        version = 'harpoon2'
    }
})

local harpoon = require 'harpoon'
harpoon:setup()

local harpoon_extensions = require 'harpoon.extensions'
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

local map = vim.keymap.set

map("n", "<leader>p", function()
    harpoon:list():add()
    print('#' .. harpoon:list():length() .. ' Buffie Hooked')
end, { desc = "Hook the buffer" })

map("n", "<leader>m", function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), {
        title = '<<--- HARPOOON --->>',
        title_pos = 'center',
        border = 'rounded',
    })
end, { desc = "Poon menu" })

local harpoon_list = harpoon:list()
map("n", "<leader>1", function()
    harpoon_list:select(1)
end, { desc = "Harp 1" })
map("n", "<leader>2", function()
    harpoon_list:select(2)
end, { desc = "Harp 2" })
map("n", "<leader>3", function()
    harpoon_list:select(3)
end, { desc = "Harp 3" })
map("n", "<leader>4", function()
    harpoon_list:select(4)
end, { desc = "Harp 4" })
