return {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('lspsaga').setup({
            ui = {
                winblend = 10,
                border = 'rounded',
                colors = {
                    normal_bg = '#002b36',
                },
            },
            lightbulb = {
                enable = true,
                enable_in_insert = true,
                sign = true,
                sign_priority = 40,
                virtual_text = true,
            },
            preview = {
                lines_above = 0,
                lines_below = 10,
            },
            scroll_preview = {
                scroll_down = '<C-f>',
                scroll_up = '<C-b>',
            },
            request_timeout = 2000,
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                keys = {
                    jump_to = 'p',
                    expand_or_jump = 'o',
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    tabnew = 'r',
                    quit = { 'q', '<ESC>' },
                    close_in_preview = '<ESC>',
                },
            },
            definition = {
                edit = '<C-c>o',
                vsplit = '<C-c>v',
                split = '<C-c>i',
                tabe = '<C-c>t',
                quit = 'q',
            },
            code_action = {
                num_shortcut = true,
                show_server_name = false,
                extend_gitsigns = true,
                keys = {
                    quit = 'q',
                    exec = '<CR>',
                },
            },
            diagnostic = {
                on_insert = false,
                on_insert_follow = false,
                insert_winblend = 0,
                show_code_action = true,
                show_source = true,
                jump_num_shortcut = true,
                max_width = 0.7,
                custom_fix = nil,
                custom_msg = nil,
                text_hl_follow = false,
                border_follow = true,
                keys = {
                    exec_action = 'o',
                    quit = 'q',
                    go_action = 'g',
                },
            },
            rename = {
                quit = '<C-c>',
                exec = '<CR>',
                mark = 'x',
                confirm = '<CR>',
                in_select = true,
            },
            outline = {
                win_position = 'right',
                win_with = '',
                win_width = 30,
                show_detail = true,
                auto_preview = true,
                auto_refresh = true,
                auto_close = true,
                custom_sort = nil,
                keys = {
                    jump = 'o',
                    expand_collapse = 'u',
                    quit = 'q',
                },
            },
            callhierarchy = {
                show_detail = false,
                keys = {
                    edit = 'e',
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    jump = 'o',
                    quit = 'q',
                    expand_collapse = 'u',
                },
            },
            symbol_in_winbar = {
                enable = true,
                separator = ' ',
                ignore_patterns = {},
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
        })

        -- Key mappings
        local keymap = vim.keymap
        keymap.set('n', '<leader>lf', '<cmd>Lspsaga finder<CR>', { desc = 'LSP Finder' })
        keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code Action' })
        keymap.set('v', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code Action' })
        keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { desc = 'Rename' })
        keymap.set('n', '<leader>rN', '<cmd>Lspsaga rename ++project<CR>', { desc = 'Rename (Project)' })
        keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek Definition' })
        keymap.set('n', '<leader>gd', '<cmd>Lspsaga goto_definition<CR>', { desc = 'Goto Definition' })
        keymap.set('n', '<leader>pt', '<cmd>Lspsaga peek_type_definition<CR>', { desc = 'Peek Type Definition' })
        keymap.set('n', '<leader>gt', '<cmd>Lspsaga goto_type_definition<CR>', { desc = 'Goto Type Definition' })
        keymap.set('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>', { desc = 'Show Line Diagnostics' })
        keymap.set('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>', { desc = 'Show Buffer Diagnostics' })
        keymap.set('n', '<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics<CR>',
            { desc = 'Show Workspace Diagnostics' })
        keymap.set('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { desc = 'Show Cursor Diagnostics' })
        keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = 'Previous Diagnostic' })
        keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = 'Next Diagnostic' })
        keymap.set('n', '[E', function()
            require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Previous Error' })
        keymap.set('n', ']E', function()
            require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Next Error' })
        keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { desc = 'Toggle Outline' })
        keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Hover Documentation' })
        keymap.set('n', '<leader>K', '<cmd>Lspsaga hover_doc ++keep<CR>', { desc = 'Hover Documentation (Keep)' })
        keymap.set('n', '<Leader>ci', '<cmd>Lspsaga incoming_calls<CR>', { desc = 'Incoming Calls' })
        keymap.set('n', '<Leader>co', '<cmd>Lspsaga outgoing_calls<CR>', { desc = 'Outgoing Calls' })
    end,
}
