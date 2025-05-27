-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'lervag/vimtex',
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_syntax_enabled = 1
        end,
    },
    {
        'stevearc/overseer.nvim',
        config = function()
            require('overseer').setup {
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
            }
        end,
    },
    {
        'obsidian-nvim/obsidian.nvim',
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
                        path = '~/Documents/Obsidian/Happy Fun Land/',
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
                        opts = { buffer = true, desc = 'Obsidian Toggle Checkbox' },
                    },
                    ['<leader>sv'] = { action = '<cmd>ObsidianQuickSwitch<cr>', opts = { desc = '[S]earch Obsidian [V]ault', buffer = true } },
                    ['<leader>os'] = { action = '<cmd>ObsidianQuickSwitch<cr>', opts = { desc = '[O]bsidian [S]earch Vault', buffer = true } },
                    ['<leader>oo'] = { action = '<cmd>ObsidianOpen<cr>', opts = { desc = '[O]bsidian [O]pen', buffer = true } },
                    ['<leader>ob'] = { action = '<cmd>ObsidianBacklinks<cr>', opts = { desc = '[O]bsidian Get [B]acklinks', buffer = true } },
                    ['<leader>od'] = { action = '<cmd>ObsidianToday<cr>', opts = { desc = '[O]bsidian Create [D]aily Note', buffer = true } },

                    -- ['<leader>ch'] = false,
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = '01 Chronos',
                },
                note_id_func = function(title)
                    return title
                end,
            }

            vim.opt_local.conceallevel = 1
        end,
    },
    {
        'jalvesaq/zotcite',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        -- ft = { 'markdown', 'tex' },
        config = function()
            require('zotcite').setup {
                -- your options here (see doc/zotcite.txt)
                open_in_zotero = true,
            }
        end,
    },

    {
        'bullets-vim/bullets.vim',
        ft = { 'markdown' },
        init = function()
            vim.g.bullets_set_mappings = 0

            -- 2. provide your own maps (array-of-arrays)
            vim.g.bullets_custom_mappings = {
                { 'imap', '<CR>', '<Plug>(bullets-newline)' }, -- ↩ in insert
                { 'inoremap', '<C-CR>', '<CR>' }, -- Ctrl-↩ literal newline
                { 'nmap', 'o', '<Plug>(bullets-newline)' }, -- o in normal
                { 'vmap', 'gN', '<Plug>(bullets-renumber)' },
                { 'nmap', 'gN', '<Plug>(bullets-renumber)' },
                -- { 'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)' },

                { 'imap', '<C-t>', '<Plug>(bullets-demote)' },
                { 'nmap', '>>', '<Plug>(bullets-demote)' },
                { 'vmap', '>', '<Plug>(bullets-demote)' },

                { 'imap', '<C-d>', '<Plug>(bullets-promote)' },
                { 'nmap', '<<', '<Plug>(bullets-promote)' },
                { 'vmap', '<', '<Plug>(bullets-promote)' },
            }
        end,
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
        end,
    },
    {
        'gelguy/wilder.nvim',
        lazy = false,
        event = 'CmdlineEnter',
        build = ':UpdateRemotePlugins',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local wilder = require 'wilder'
            wilder.setup {
                modes = { ':' },
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
            per_buffer_config = {
                -- treesitter_context = { line_shift_down = 2 },
            },
        },
    },
    -- {
    --     'tadaa/vimade',
    --     opts = {
    --         fadelevel = 0.8,
    --         blocklist = {
    --             -- replace the built-in function
    --             default_block_floats = function(win, _)
    --                 -- block every window whose config shows it’s a float
    --                 return win.win_config.relative ~= ''
    --             end,
    --             arrow_float = {
    --                 buf_opts = { buftype = { 'nofile' } },
    --                 buf_name = { '/^Arrow.*/' }, -- Lua-pattern between the slashes
    --             },
    --         },
    --     },
    -- },
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
    {
        'debugloop/telescope-undo.nvim',
        dependencies = { -- note how they're inverted to above example
            {
                'nvim-telescope/telescope.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
            },
        },
        keys = {
            { -- lazy style key map
                '<leader>u',
                '<cmd>Telescope undo<cr>',
                desc = 'undo history',
            },
        },
        opts = {
            -- don't use `defaults = { }` here, do this in the main telescope spec
            extensions = {
                undo = {
                    -- telescope-undo.nvim config, see below
                },
                -- no other extensions here, they can have their own spec too
            },
        },
        config = function(_, opts)
            -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
            -- configs for us. We won't use data, as everything is in it's own namespace (telescope
            -- defaults, as well as each extension).
            require('telescope').setup(opts)
            require('telescope').load_extension 'undo'
        end,
    },
    {
        'NotAShelf/direnv.nvim',
        config = function()
            require('direnv').setup {
                autoload_direnv = true,
                statusline = { enabled = true, icon = '󱚟' },
                keybindings = {
                    allow = '<Leader>va',
                    deny = '<Leader>vd',
                    reload = '<Leader>vr',
                    edit = '<Leader>ve',
                },
            }
        end,
    },
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            -- you'll need at least one of these
            -- {'nvim-telescope/telescope.nvim'},
            -- {'ibhagwan/fzf-lua'},
        },
        config = function()
            require('neoclip').setup()
            vim.keymap.set({ 'n', 'x' }, '<leader>sc', '<cmd>Telescope neoclip<CR>', { desc = '[S]earch [C]lipboard (Neoclip)' })
        end,
    },
    {
        'arnamak/stay-centered.nvim',
        config = function()
            require('stay-centered').setup()
        end,
    },
    {
        'LudoPinelli/comment-box.nvim',
        config = function()
            local keymap = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- Titles
            keymap({ 'n', 'v' }, '<Leader>mb', '<Cmd>CBccbox<CR>', { noremap = true, silent = true, desc = 'CommentBox Title' })
            -- Named parts
            keymap({ 'n', 'v' }, '<Leader>mt', '<Cmd>CBllline<CR>', { noremap = true, silent = true, desc = 'CommentBox Titled Line' })
            -- Simple line
            keymap('n', '<Leader>ml', '<Cmd>CBline<CR>', { noremap = true, silent = true, desc = 'CommentBox Simple Line' })
            -- keymap("i", "<M-l>", "<Cmd>CBline<CR>", opts) -- To use in Insert Mode
            -- Marked comments
            keymap({ 'n', 'v' }, '<Leader>mm', '<Cmd>CBllbox14<CR>', { noremap = true, silent = true, desc = 'CommentBox Marked' })
            -- Removing a box is simple enough with the command (CBd), but if you
            -- use it a lot:
            keymap({ 'n', 'v' }, '<Leader>md', '<Cmd>CBd<CR>', { noremap = true, silent = true, desc = 'CommentBox Remove' })
        end,
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
        event = { 'User KittyScrollbackLaunch' },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
        config = function()
            require('kitty-scrollback').setup()
        end,
    },
    {
        'subnut/nvim-ghost.nvim',
    },
    {
        'jake-stewart/multicursor.nvim',
        branch = '1.0',
        config = function()
            local mc = require 'multicursor-nvim'
            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ 'n', 'x' }, '<up>', function()
                mc.lineAddCursor(-1)
            end)
            set({ 'n', 'x' }, '<down>', function()
                mc.lineAddCursor(1)
            end)
            set({ 'n', 'x' }, '<Tab><up>', function()
                mc.lineSkipCursor(-1)
            end)
            set({ 'n', 'x' }, '<Tab><down>', function()
                mc.lineSkipCursor(1)
            end)
            set({ 'n', 'x' }, '<Tab>k', function()
                mc.lineAddCursor(-1)
            end)
            set({ 'n', 'x' }, '<Tab>j', function()
                mc.lineAddCursor(1)
            end)
            set({ 'n', 'x' }, '<Tab>K', function()
                mc.lineSkipCursor(-1)
            end)
            set({ 'n', 'x' }, '<Tab>J', function()
                mc.lineSkipCursor(1)
            end)

            -- Add or skip adding a new cursor by matching word/selection
            set({ 'n', 'x' }, '<Tab>n', function()
                mc.matchAddCursor(1)
            end, { desc = 'Add new cursor at next matching word' })
            set({ 'n', 'x' }, '<Tab>s', function()
                mc.matchSkipCursor(1)
            end, { desc = 'Skip cursor at next matching word' })
            set({ 'n', 'x' }, '<Tab>N', function()
                mc.matchAddCursor(-1)
            end, { desc = 'Skip cursor at prev matching word' })
            set({ 'n', 'x' }, '<Tab>S', function()
                mc.matchSkipCursor(-1)
            end, { desc = 'Add new cursor at prev matching word' })

            -- Add and remove cursors with control + left click.
            set('n', '<c-leftmouse>', mc.handleMouse)
            set('n', '<c-leftdrag>', mc.handleMouseDrag)
            set('n', '<c-leftrelease>', mc.handleMouseRelease)

            -- Disable and enable cursors.
            set({ 'n', 'x' }, '<c-q>', mc.toggleCursor)

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)
                -- Select a different cursor as the main one.
                layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
                layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

                -- Delete the main cursor.
                layerSet({ 'n', 'x' }, '<Tab>x', mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet('n', '<esc>', function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, 'MultiCursorCursor', { reverse = true })
            hl(0, 'MultiCursorVisual', { link = 'Visual' })
            hl(0, 'MultiCursorSign', { link = 'SignColumn' })
            hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
            hl(0, 'MultiCursorDisabledCursor', { reverse = true })
            hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
            hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
        end,
    },
}
