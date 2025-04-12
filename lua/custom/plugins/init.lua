-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            'mfussenegger/nvim-dap-python', --optional
            { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
        },
        lazy = false,
        branch = 'regexp', -- This is the regexp branch, use this for the new version
        keys = {
            -- { ',v', '<cmd>VenvSelect<cr>' },
        },
        config = function()
            require('venv-selector').setup {
                -- anaconda_base_path = vim.fn.expand '~' .. '/miniconda3/',
                -- anaconda_envs_path = vim.fn.expand '~' .. '/miniconda3/envs',
            }
            -- Function to reconfigure dap-python based on selected venv
            vim.keymap.set('n', '<leader>dv', ':VenvSelect<cr>', { noremap = true, nowait = true, desc = 'Set [D]ocument [V]env' })
        end,
    },
    {
        'lervag/vimtex',
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_general_viewer = 'sumatrapdf'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            vim.g.vimtex_syntax_enabled = 1
        end,
    },
    {
        'stevearc/overseer.nvim',
        opts = {},
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*', -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        --   -- refer to `:h file-pattern` for more examples
        --   "BufReadPre path/to/my-vault/*.md",
        --   "BufNewFile path/to/my-vault/*.md",
        -- },
        dependencies = {
            -- Required.
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('obsidian').setup {
                workspaces = {
                    {
                        name = 'vault',
                        path = '~/OneDrive - University of Cambridge/Documents/Obsidian/Happy Fun Land/',
                    },
                },
            }
            vim.keymap.set('n', '<leader>sv', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[S]earch Obsidian [V]ault' })
            vim.keymap.set('n', '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[O]bsidian [S]earch Vault' })
            vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianOpen<cr>', { desc = '[O]bsidian Get [B]acklinks' })
            vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', { desc = '[O]bsidian Get [B]acklinks' })
            vim.keymap.set('n', '<leader>od', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian Create [D]aily Note' })
            vim.opt_local.conceallevel = 1
        end,
    },
    {
        'jalvesaq/zotcite',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        ft = { 'markdown', 'tex' },
        config = function()
            require('zotcite').setup {
                -- your options here (see doc/zotcite.txt)
                open_in_zotero = true,
            }
        end,
    },
    {
        'jalvesaq/cmp-zotcite',
        ft = { 'markdown', 'tex' },
        opts = {},
    },
    {
        'bullets-vim/bullets.vim',
        ft = { 'markdown' },
    },
    {
        {
            'lukas-reineke/headlines.nvim',
            after = 'nvim-treesitter',
            config = function()
                require('headlines').setup {
                    markdown = {
                        fat_headlines = false,
                    },
                }
            end,
        },
        {
            'stevearc/quicker.nvim',
            event = 'FileType qf',
            ---@module "quicker"
            ---@type quicker.SetupOptions
            opts = {},
        },
    },
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        version = '12.0.1',
        config = function()
            local dropbar_api = require 'dropbar.api'
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

            require('dropbar').setup {
                menu = {
                    keymaps = {},
                },
            }
        end,
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        config = function()
            local auto_session = require 'auto-session'
            auto_session.setup {
                auto_restore = true,
                auto_save = true,
                suppressed_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Desktop/' },
                pre_save_cmds = { 'OverseerClose' },
            }
            vim.keymap.set('n', '<leader>ww', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' })
            vim.keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' })
        end,
    },
    {
        'gelguy/wilder.nvim',
        event = 'CmdlineEnter',
        build = ':UpdateRemotePlugins',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local wilder = require 'wilder'
            wilder.setup {
                modes = { ':', '/', '?' },
                next_key = '<C-N>',
                previous_key = '<C-P>',
                accept_key = '<C-Y>',
                reject_key = '<esc>',
            }
            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.python_file_finder_pipeline {
                        file_command = function(_, arg)
                            if string.find(arg, '.') ~= nil then
                                return { 'fd', '-tf', '-H' }
                            else
                                return { 'fd', '-tf' }
                            end
                        end,
                        dir_command = { 'fd', '-td' },
                        filters = { 'fuzzy_filter', 'difflib_sorter' },
                    },
                    wilder.cmdline_pipeline(),
                    wilder.python_search_pipeline()
                ),
            })

            wilder.set_option(
                'renderer',
                wilder.popupmenu_renderer {
                    highlighter = wilder.basic_highlighter(),
                    left = { ' ', wilder.popupmenu_devicons() },
                    right = { ' ', wilder.popupmenu_scrollbar { thumb_char = ' ' } },
                    highlights = {
                        default = 'WilderMenu',
                        accent = wilder.make_hl('WilderAccent', 'Pmenu', {
                            { a = 1 },
                            { a = 1 },
                            { foreground = '#f4468f' },
                        }),
                    },
                }
            )
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter',
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = true },
            picker = { enabled = false },
            notifier = {
                enabled = true,
                timeout = 3000, -- default timeout in ms
                width = { min = 40, max = 0.4 },
                height = { min = 1, max = 0.6 },
                -- editor margin to keep free. tabline and statusline are taken into account automatically
                margin = { top = 0, right = 1, bottom = 0 },
                padding = true, -- add 1 cell of left/right padding to the notification window
                sort = { 'level', 'added' }, -- sort by level and time
                -- minimum log level to display. TRACE is the lowest
                -- all notifications are stored in history
                level = vim.log.levels.TRACE,
                icons = {
                    error = ' ',
                    warn = ' ',
                    info = ' ',
                    debug = ' ',
                    trace = ' ',
                },
                keep = function(notif)
                    return vim.fn.getcmdpos() > 0
                end,
                ---@type snacks.notifier.style
                style = 'compact',
                top_down = true, -- place notifications from top to bottom
                date_format = '%R', -- time format for notifications
                -- format for footer when more lines are available
                -- `%d` is replaced with the number of lines.
                -- only works for styles with a border
                ---@type string|boolean
                more_format = ' ↓ %d lines ',
                refresh = 50, -- refresh at most every 50ms
            },
            notify = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            terminal = {
                enable = true,
                win = { position = 'float' },
            },
            styles = {
                terminal = {
                    bo = {
                        filetype = 'snacks_terminal',
                    },
                    wo = {},
                    keys = {
                        q = 'hide',
                        gf = function(self)
                            local f = vim.fn.findfile(vim.fn.expand '<cfile>', '**')
                            if f == '' then
                                Snacks.notify.warn 'No file under cursor'
                            else
                                self:hide()
                                vim.schedule(function()
                                    vim.cmd('e ' .. f)
                                end)
                            end
                        end,
                        term_normal = {
                            '<esc>',
                            function(self)
                                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                                if self.esc_timer:is_active() then
                                    self.esc_timer:stop()
                                    vim.cmd 'stopinsert'
                                else
                                    self.esc_timer:start(200, 0, function() end)
                                    return '<esc>'
                                end
                            end,
                            mode = 't',
                            expr = true,
                            desc = 'Double escape to normal mode',
                        },
                    },
                },
            },
        },
        keys = {
            {
                '<c-\\>',
                function()
                    Snacks.terminal()
                end,
                desc = 'Toggle Terminal',
            },
        },
    },
    {
        'folke/trouble.nvim',
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
    -- {
    --     'ghostbuster91/nvim-next',
    --     config = function()
    --         require('nvim-next').setup {
    --             default_mappings = {
    --                 repeat_style = 'original',
    --             },
    --         }
    --         local next_move = require 'nvim-next.move'
    --         local MiniAi = require 'mini.ai'
    --         local user_input = nil
    --         local move_to_text_obj = function(side)
    --             local prev_txt_obj, next_txt_obj = next_move.make_repeatable_pair(function()
    --                 if user_input == nil then
    --                     user_input = vim.fn.getchar()
    --                 end
    --                 MiniAi.move_cursor(side, 'a', user_input, { search_method = 'cover_or_next' })
    --             end, function()
    --                 if user_input == nil then
    --                     user_input = vim.fn.getchar()
    --                 end
    --                 MiniAi.move_cursor(side, 'a', user_input, { search_method = 'cover_or_prev' })
    --             end)
    --             return { prev_txt_obj, next_txt_obj }
    --         end
    --         local left_side = move_to_text_obj 'left'
    --         vim.keymap.set({ 'n', 'v' }, ']t', left_side[2], { desc = 'Jump to next text object' })
    --         vim.keymap.set({ 'n', 'v' }, '[t', left_side[1], { desc = 'Jump to previous text object' })
    --     end,
    -- },
    -- {
    --     'AckslD/nvim-neoclip.lua',
    --     dependencies = {
    --         -- you'll need at least one of these
    --         { 'nvim-telescope/telescope.nvim' },
    --         -- {'ibhagwan/fzf-lua'},
    --     },
    --     config = function()
    --         require('neoclip').setup {
    --             default_register = { '"' },
    --             keys = {
    --                 telescope = {
    --                     i = {
    --                         select = '<cr>',
    --                         paste = '<c-y>',
    --                         paste_behind = '<c-k>',
    --                         replay = '<c-q>', -- replay a macro
    --                         delete = '<c-d>', -- delete an entry
    --                         edit = '<c-e>', -- edit an entry
    --                         custom = {},
    --                     },
    --                     n = {
    --                         select = '<cr>',
    --                         paste = 'p',
    --                         --- It is possible to map to more than one key.
    --                         -- paste = { 'p', '<c-p>' },
    --                         paste_behind = 'P',
    --                         replay = 'q',
    --                         delete = 'd',
    --                         edit = 'e',
    --                         custom = {},
    --                     },
    --                 },
    --             },
    --         }
    --         vim.keymap.set({ 'n', 'v' }, '<leader>p', '<cmd>Telescope neoclip<CR>')
    --     end,
    -- },
    {
        'otavioschwanck/arrow.nvim',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' },
            -- or if using `mini.icons`
            -- { "echasnovski/mini.icons" },
        },
        opts = {
            show_icons = true,
            leader_key = '\\', -- Recommended to be a single key
            buffer_leader_key = 'm', -- Per Buffer Mappings
        },
    },
    {
        'tadaa/vimade',
        opts = {
            fadelevel = 0.8,
        },
    },
}
