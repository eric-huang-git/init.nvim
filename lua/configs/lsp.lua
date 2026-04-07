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
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local vim_buf = vim.lsp.buf
        local tel_built = require('telescope.builtin')
        map('grn', vim_buf.rename, '[R]e[n]ame')
        map('gra', vim_buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', tel_built.lsp_references, '[G]oto [R]eferences')
        map('gri', tel_built.lsp_implementations, '[G]oto [I]mplementation')
        map('grd', tel_built.lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim_buf.declaration, '[G]oto [D]eclaration')
        map('gO', tel_built.lsp_document_symbols, 'Open Document Symbols')
        map('gW', tel_built.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        map('grt', tel_built.lsp_type_definitions, '[G]oto [T]ype Definition')
    end,
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf, async = false })
    end,
})

vim.diagnostic.config({
    float = { border = 'rounded' },
})
