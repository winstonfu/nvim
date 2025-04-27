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
            vim.keymap.set('n', '<leader>dv', '<cmd>VenvSelect<cr>', { noremap = true, nowait = true, silent = true, desc = 'Set [D]ocument [V]env' })
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
        opts = {
            task_list = {
                bindings = {
                    ['<M-l>'] = 'IncreaseDetail',
                    ['<M-h>'] = 'DecreaseDetail',
                    ['<M-k>'] = 'ScrollOutputUp',
                    ['<M-j>'] = 'ScrollOutputDown',
                    ['<C-l>'] = false,
                    ['<C-h>'] = false,
                    ['<C-k>'] = false,
                    ['<C-j>'] = false,
                },
            },
        },
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
                mappings = {
                    ['<c-cr>'] = {
                        action = function()
                            return require('obsidian').util.smart_action()
                        end,
                        opts = { buffer = true, expr = true },
                    },
                    ['<leader>oc'] = {
                        action = function()
                            return require('obsidian').util.toggle_checkbox()
                        end,
                        opts = { buffer = true },
                    },
                    -- ['<leader>ch'] = false,
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = '01 Chronos',
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
                reject_key = '',
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
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter',
        config = function()
            require('treesitter-context').setup { enable = false }
            vim.keymap.set('n', '<leader>tc', '<cmd>TSContextToggle<cr>', { desc = '[T]oggle [C]ontext Preview' })
        end,
    },
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
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { 'echasnovski/mini.icons', opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}
