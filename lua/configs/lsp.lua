vim.pack.add(
    {
        'https://github.com/saghen/blink.cmp',
        "https://github.com/neovim/nvim-lspconfig"
    }
)
local has_blink, blink = pcall(require, 'blink.cmp')
local capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
local vue_plugin_path = '/usr/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin'

local configs = {
    pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { '.git', 'pyproject.toml', 'setup.py' },
    },
    lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.git', '.luarc.json' },
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            },
        },
    },
    clangd = {
        cmd = { 'clangd', '--background-index', '--clang-tidy' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { '.git', 'compile_commands.json', 'compile_flags.txt' },
    },
    gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
    },
    bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_markers = { '.git' },
    },
    rust_analyzer = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
        settings = {
            ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } }
        }
    },
    html = {
        cmd = { 'vscode-html-languageserver', '--stdio' },
        filetypes = { 'html' },
        root_markers = { '.git', 'package.json' },
    },
    cssls = {
        cmd = { 'vscode-css-languageserver', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { '.git', 'package.json' },
    },
    vue_ls = {
        cmd = { 'vue-language-server', '--stdio' },
        filetypes = { 'vue' },
        init_options = {
            vue = {
                hybridMode = true,
            },
        }
    },

    ts_ls = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
            plugins = {
                {
                    name = '@vue/typescript-plugin',
                    location = vue_plugin_path,
                    languages = { 'javascript', 'typescript', 'vue' },
                },
            },
        },
    }
}

for name, config in pairs(configs) do
    config.capabilities = capabilities
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

if has_blink then
    blink.setup({
        keymap = { preset = 'default' },

        cmdline = {
            completion = { menu = { auto_show = true } },
        },
        completion = {
            menu = { auto_show = true, border = 'rounded' },
            documentation = { auto_show = true, window = { border = 'rounded' } },
            ghost_text = { enabled = true },
        },
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf, async = false })
    end,
})

vim.diagnostic.config({
    float = { border = 'rounded' },
})
