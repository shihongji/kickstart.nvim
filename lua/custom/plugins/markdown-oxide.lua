return {
    -- Setup markdown-oxide LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'mason-org/mason-lspconfig.nvim' },
        config = function()
            -- Get the capabilities from blink.cmp
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Configure markdown-oxide
            require('lspconfig').markdown_oxide.setup({
                capabilities = vim.tbl_deep_extend('force', capabilities, {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }),
                on_attach = function(client, bufnr)
                    -- Setup Markdown Oxide daily note commands
                    if client.name == "markdown_oxide" then
                        vim.api.nvim_create_user_command(
                            "Daily",
                            function(args)
                                local input = args.args
                                vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
                            end,
                            { desc = 'Open daily note', nargs = "*" }
                        )
                    end

                    -- Code lens support for reference counts (fixed deprecated syntax)
                    local function check_codelens_support()
                        -- Updated syntax - removed 'active' from function name
                        local clients = vim.lsp.get_clients({ bufnr = bufnr })
                        for _, c in ipairs(clients) do
                            if c.server_capabilities.codeLensProvider then
                                return true
                            end
                        end
                        return false
                    end

                    if check_codelens_support() then
                        vim.api.nvim_create_autocmd(
                            { 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.codelens.refresh({ bufnr = bufnr })
                                end
                            })
                    end
                end,
                filetypes = { 'markdown' },
                root_dir = function(fname)
                    return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
                end,
            })
        end,
    },
}
