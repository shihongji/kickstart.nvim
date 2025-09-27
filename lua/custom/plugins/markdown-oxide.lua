return {
    -- Setup markdown-oxide LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'mason-org/mason-lspconfig.nvim' },
        config = function()
            -- Get the capabilities from blink.cmp
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Use vim.lsp.config to define the server configuration
            vim.lsp.config('markdown_oxide', {
                capabilities = vim.tbl_deep_extend('force', capabilities, {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }),
                -- You can add filetypes and root_dir directly in the config table
                filetypes = { 'markdown' },
                root_dir = function(fname)
                    return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
                end,
            })

            -- Create the LspAttach autocommand to handle client-specific logic
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('MarkdownLspAttach', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local bufnr = args.buf

                    -- Check if the attached client is markdown-oxide
                    if client and client.name == "markdown_oxide" then
                        -- Setup Markdown Oxide daily note command
                        vim.api.nvim_create_user_command("Daily", function(cmd_args)
                            local input = cmd_args.args
                            vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
                        end, { desc = 'Open daily note', nargs = "*" })

                        -- Check for codelens support and set up a refresh autocommand
                        if client.server_capabilities.codeLensProvider then
                            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.codelens.refresh({ bufnr = bufnr })
                                end
                            })
                        end
                    end
                end,
            })

            -- Call vim.lsp.enable to activate the markdown_oxide server config
            vim.lsp.enable('markdown_oxide')
        end,
    },
}