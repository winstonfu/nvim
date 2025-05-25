-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--     vim.opt.clipboard = 'unnamedplus'
-- end)
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to OS clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+yg_', { desc = '[Y]ank to OS clipboard to end of line' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = '[P]aste from OS clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = '[P]aste from OS clipboard before cursor' })
vim.keymap.set({ 'n' }, 'gp', '`[v`]', { desc = 'Select pasted text' })

-- Enable break indent
vim.opt.breakindent = true

-- Indent and tab settings
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Indent size = 4
vim.opt.tabstop = 4 -- Tab character is 4 spaces wide
vim.opt.softtabstop = 4 -- When pressing Tab, insert 4 spaces

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'nosplit'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- vim.opt.scrolloff = 999

-- -- Centre cursor
-- vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
--     callback = function()
--         vim.cmd 'normal! zz'
--     end,
-- })

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Set title of window
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = 'nvim %{expand("%:p")}'

-- Neovide
vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_trail_size = 0

-- Set python dir
vim.g.python3_host_prog = '~/.virtualenvs/nvim/bin/python'

-- Enable autochdir
-- vim.opt.autochdir = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setloclist, { desc = 'Open [Q]uickfix [D]iagnostic list' })

-- Start and end of line
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '_')
vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$')
vim.keymap.set({ 'n', 'x', 'o' }, 'M', '%')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Show args when calling function or class.
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })

-- Insert new line
-- vim.keymap.set('n', '<CR>', 'o<esc>', { desc = 'Insert new line without exiting normal mode' })
-- vim.keymap.set('n', '<S-CR>', 'O<esc>', { desc = 'Insert new line above without exiting normal mode' })

-- Delete first and last line of selection
vim.keymap.set('x', '<leader>d', function()
    local k = vim.v.count1 -- (1) get the count, defaults to 1  :contentReference[oaicite:0]{index=0}

    -- leave Visual so that '< and '> are written
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<Esc>', true, false, true), -- translate <Esc>
        'x', -- 'x' ⇒ execute immediately, do remap              :contentReference[oaicite:1]{index=1}
        false
    )

    -- build the Ex command that encodes (2)
    local cmd = string.format("'>-%d,'>d | '<,'<+%dd", k - 1, k - 1)
    vim.cmd(cmd)
end, { silent = true, desc = 'Delete first and last ' .. vim.v.count1 .. ' line(s) of selection' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Open external files
vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = '*.pdf',
    callback = function()
        local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
        vim.cmd('silent !start "" ' .. filename .. ' &')
        vim.cmd 'let tobedeleted = bufnr(\'%\') | b# | exe "bd! " . tobedeleted'
    end,
})

vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' },
    callback = function()
        local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
        vim.cmd('silent !start "" ' .. filename .. ' &')
        vim.cmd 'let tobedeleted = bufnr(\'%\') | b# | exe "bd! " . tobedeleted'
    end,
})

-- -- Allow :wqa with terminal buffers open
-- vim.api.nvim_create_autocmd('TermOpen', {
--     pattern = '*',
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--     end,
-- })

-- Folds
vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost', 'BufWrite' }, {
    callback = function()
        vim.defer_fn(function()
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.opt.foldlevel = 99 -- allow all folds to remain open
            vim.opt.foldlevelstart = 99 -- applies at startup
            vim.opt.foldenable = true
            vim.cmd 'normal! zx' -- now zx will NOT close everything
        end, 0)
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'www.overleaf.com',
    group = vim.api.nvim_create_augroup('nvim_ghost_user_autocommands', { clear = true }),
    callback = function(ev)
        local buf = ev.buf
        vim.bo[buf].filetype = 'tex'
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
    --

    -- Alternatively, use `config = function() ... end` for full control over the configuration.
    -- If you prefer to call `setup` explicitly, use:
    --    {
    --        'lewis6991/gitsigns.nvim',
    --        config = function()
    --            require('gitsigns').setup({
    --                -- Your gitsigns configuration here
    --            })
    --        end,
    --    }
    --
    -- Here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`.
    --
    -- See `:help gitsigns` to understand what the configuration keys do
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `opts` key (recommended), the configuration runs
    -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            preset = 'helix',
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            -- Document existing key chains
            spec = {
                { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
                { '<leader>l', group = '[L]aTeX', mode = { 'n' } },
                { '<leader>o', group = '[O]bsidian', mode = { 'n' } },
                { '<leader>b', group = 'De[b]ug', mode = { 'n' } },
                { '<leader>x', group = 'Diagnostis (Trouble)', mode = { 'n' } },
                { '<leader>v', group = 'Diren[v]', mode = { 'n' } },
                { '<leader>z', group = '[Z]otcite', mode = { 'n' } },
                { '<leader>m', group = 'Co[m]ment Blocks', mode = { 'n' } },
            },
        },
        keys = {
            {
                '<c-w><space>',
                function()
                    require('which-key').show { keys = '<c-w>', loop = true }
                end,
                desc = 'Window Hydra Mode (which-key)',
            },
            {
                ']<space>',
                function()
                    require('which-key').show { keys = ']', loop = true }
                end,
                desc = 'Bracket jump forward Hydra Mode (which-key)',
            },
            {
                '[<space>',
                function()
                    require('which-key').show { keys = '[', loop = true }
                end,
                desc = 'Bracket jump backward Hydra Mode (which-key)',
            },
            {
                '<leader>?',
                function()
                    require('which-key').show { global = false }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },

    -- NOTE: Plugins can specify dependencies.
    --
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin

    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
            { 'benfowler/telescope-luasnip.nvim' },
        },
        config = function()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- Telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. hin here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    mappings = {
                        i = {
                            ['<c-enter>'] = 'to_fuzzy_refine',
                            -- ['<c-V>'] = false,
                            -- ['<c-b>'] = 'select_vertical',
                            ['<c-h>'] = 'which_key',
                        },
                    },
                    preview = {
                        filesize_limit = 1,
                        timeout_ms = 100,
                        -- 1) Do not show previewer for certain files
                        filetype_hook = function(filepath, bufnr, opts)
                            -- you could analogously check opts.ft for filetypes
                            local putils = require 'telescope.previewers.utils'
                            local excluded = vim.tbl_filter(function(ending)
                                return filepath:match(ending)
                            end, {
                                '.*%.csv',
                                '.*%.json',
                                '.*%.pkl',
                                '.*%.parquet',
                            })
                            if not vim.tbl_isempty(excluded) then
                                putils.set_preview_message(bufnr, opts.winid, string.format("I don't like %s files!", excluded[1]:sub(5, -1)))
                                return false
                            end
                            return true
                        end,
                    },
                    path_display = { 'truncate' },
                },
                pickers = {
                    lsp_document_symbols = {
                        fname_width = 30, -- Increase width allocated for names
                        symbol_width = 50, -- Adjust if needed
                        symbol_type_width = 15, -- Adjust type column width
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'luasnip')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>sl', require('telescope').extensions.luasnip.luasnip, { desc = '[S]earch [L]uaSnip Snippets' })

            if vim.fn.filereadable 'tags' == 1 then
                vim.keymap.set('n', '<leader>st', builtin.tags { desc = '[S]earch tags' })
            end

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },
    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Brief aside: **What is LSP?**
            --
            -- LSP is an initialism you've probably heard, but might not understand what it is.
            --
            -- LSP stands for Language Server Protocol. It's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- In general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
            -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
            -- processes that communicate with some "client" - in this case, Neovim!
            --
            -- LSP provides Neovim with features like:
            --  - Go to definition
            --  - Find references
            --  - Autocompletion
            --  - Symbol Search
            --  - and more!
            --
            -- Thus, Language Servers are external tools that must be installed separately from
            -- Neovim. This is where `mason` and related plugins come into play.
            --
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                    -- Find references for the word under your cursor.
                    map('grs', require('telescope.builtin').lsp_references, '[G]oto [R]eferences [S]earch')

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has 'nvim-0.11' == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
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

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local workon_home = vim.env.WORKON_HOME or vim.fn.expand '~/.virtualenvs'
            -- local venv_name = vim.fn.fnamemodify(vim.env.VIRTUAL_ENV or 'default', ':t') -- "qc-sim", etc.
            local venv_name = 'default'
            local servers = {
                -- clangd = {},
                -- gopls = {},
                pyright = {
                    settings = {
                        python = {
                            pythonPath = ('%s/%s/bin/python'):format(workon_home, venv_name),
                        },
                    },
                },
                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`ts_ls`) will work just fine
                -- ts_ls = {},
                --

                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },

                marksman = {},

                tinymist = {},

                ltex = {},

                texlab = {},

                -- texlab = {
                --     single_file_support = true,
                --     root_dir = function(bufnr, on_dir)
                --         local name = vim.api.nvim_buf_get_name(bufnr)
                --         if name == '' then -- unsaved GhostText buf
                --             return on_dir(vim.loop.cwd()) --  <-- fallback workspace
                --         end
                --         -- equivalent of util.root_pattern in lspconfig
                --         on_dir(vim.fs.root(bufnr, { '.git', '.latexmkrc', '.texlabroot' }) or vim.fs.dirname(name))
                --     end,
                -- },
            }

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            --
            -- `mason` had to be setup earlier: to configure its options see the
            -- `dependencies` table for `nvim-lspconfig` above.
            --
            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
                -- Python
                -- 'pyright',
                'mypy',
                'ruff',
                'isort',
                -- Markdown
                'marksman',
                'markdownlint',
                'prettier',
                -- Others
                'tree-sitter-cli',
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            for server_name, spec in pairs(servers) do
                vim.lsp.config(server_name, spec)
            end

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
            }
        end,
    },

    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
            { '<leader>tf', '<cmd>FormatToggle!<cr>', mode = '', desc = '[T]oggle buffer autoformat on save.' },
            { '<leader>tF', '<cmd>FormatToggle<cr>', mode = '', desc = '[T]oggle globale autoformat on save.' },
        },
        config = function()
            require('conform').setup {
                notify_on_error = false,
                format_on_save = function(bufnr)
                    -- Toggle for disabling autoformat on save.
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    -- Disable "format_on_save lsp_fallback" for languages that don't
                    -- have a well standardized coding style. You can add additional
                    -- languages here or re-enable it for the disabled ones.
                    local disable_filetypes = { c = true, cpp = true }
                    local lsp_format_opt
                    if disable_filetypes[vim.bo[bufnr].filetype] then
                        lsp_format_opt = 'never'
                    else
                        lsp_format_opt = 'fallback'
                    end
                    return {
                        timeout_ms = 2000,
                        lsp_format = lsp_format_opt,
                    }
                end,
                formatters_by_ft = {
                    lua = { 'stylua' },
                    -- Conform can also run multiple formatters sequentially
                    python = { 'isort', 'ruff_fix', 'ruff_format' },
                    tex = { 'texlab' },
                    markdown = { 'prettier' },
                    yaml = { 'prettier' },
                    --
                    -- You can use 'stop_after_first' to run the first available formatter from the list
                    -- javascript = { "prettierd", "prettier", stop_after_first = true },
                },
                formatters = {
                    isort = {
                        command = 'isort',
                        args = { '-' },
                        stdin = true,
                    },
                    ruff_fix = {
                        command = 'ruff',
                        args = { 'check', '--fix', '--stdin-filename', '$FILENAME', '-' },
                        stdin = true,
                    },
                    ruff_format = {
                        command = 'ruff',
                        args = { 'format', '-' },
                        stdin = true,
                    },
                },
            }
            vim.api.nvim_create_user_command('FormatDisable', function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = 'Disable autoformat-on-save',
                bang = true,
            })
            vim.api.nvim_create_user_command('FormatEnable', function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = 'Re-enable autoformat-on-save',
            })
            vim.api.nvim_create_user_command('FormatToggle', function(args)
                if args.bang then
                    -- FormatToggle! will toggle formatting just for this buffer
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                else
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                end
                vim.cmd.redrawstatus()
            end, {
                desc = 'Toggle autoformat-on-save',
                bang = true,
            })
        end,
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'micangl/cmp-vimtex',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {
                enable_autosnippets = true,
            }

            -- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
            require('luasnip.loaders.from_lua').lazy_load { paths = '~/.config/nvim/LuaSnip/' }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    -- If you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    --['<CR>'] = cmp.mapping.confirm { select = true },
                    --['<Tab>'] = cmp.mapping.select_next_item(),
                    --['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    {
                        name = 'lazydev',
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'cmp_zotcite' },
                    { name = 'vimtex' },
                    -- { name = 'texlab' },
                },
            }
            vim.api.nvim_set_keymap('i', '<C-n>', '<Plug>luasnip-next-choice', {})
            vim.api.nvim_set_keymap('s', '<C-n>', '<Plug>luasnip-next-choice', {})
            vim.api.nvim_set_keymap('i', '<C-p>', '<Plug>luasnip-prev-choice', {})
            vim.api.nvim_set_keymap('s', '<C-p>', '<Plug>luasnip-prev-choice', {})

            -- This does not seem to work yet as enable_autosnippets is checked once when LuaSnip is setup.
            -- vim.keymap.set('n', '<leader>ts', function()
            --     local ls = require 'luasnip'
            --     ls.config.enable_autosnippets = not ls.config.enable_autosnippets
            --     vim.cmd.redrawstatus()
            -- end, { desc = '[T]oggle [S]nippet Autoexpansion' })
        end,
    },

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('catppuccin').setup {
                styles = {
                    comments = {}, -- Disable italics in comments
                },
            }

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'catppuccin'
        end,
    },

    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            local spec_pair = require('mini.ai').gen_spec.pair
            local gen_spec = require('mini.ai').gen_spec
            require('mini.ai').setup {
                n_lines = 500,
                custom_textobjects = {
                    e = spec_pair('$', '$', { type = 'greedy' }),
                    f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
                    o = spec_treesitter {
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    },
                    h = spec_treesitter { a = '@class.outer', i = '@class.inner' },
                    g = gen_spec.function_call(),
                },
            }

            local map_mini_ai_move = function(key, textobject_id, text_object_desc)
                vim.keymap.set({ 'n', 'x', 'o' }, ']' .. string.lower(key), function()
                    for i = 1, vim.v.count1 do
                        require('mini.ai').move_cursor('left', 'a', textobject_id, { search_method = 'next' })
                    end
                end, { desc = 'Next ' .. text_object_desc .. ' Start' })
                vim.keymap.set({ 'n', 'x', 'o' }, '[' .. string.lower(key), function()
                    for i = 1, vim.v.count1 do
                        require('mini.ai').move_cursor('left', 'a', textobject_id, { search_method = 'cover_or_prev' })
                    end
                end, { desc = 'Prev' .. text_object_desc .. ' Start' })
                vim.keymap.set({ 'n', 'x', 'o' }, ']' .. string.upper(key), function()
                    for i = 1, vim.v.count1 do
                        require('mini.ai').move_cursor('right', 'a', textobject_id, { search_method = 'cover_or_next' })
                    end
                end, { desc = 'Next ' .. text_object_desc .. ' End' })
                vim.keymap.set({ 'n', 'x', 'o' }, '[' .. string.upper(key), function()
                    for i = 1, vim.v.count1 do
                        require('mini.ai').move_cursor('right', 'a', textobject_id, { search_method = 'prev' })
                    end
                end, { desc = 'Prev ' .. text_object_desc .. ' End' })
            end

            map_mini_ai_move('g', 'g', 'Function Call')
            map_mini_ai_move('f', 'f', 'Function Def')
            map_mini_ai_move('a', 'a', 'Argument')
            map_mini_ai_move('h', 'h', 'Class')
            map_mini_ai_move('o', 'o', 'Conditional / Loop')

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
            require('mini.surround').setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a Nerd Font
            statusline.setup {
                use_icons = vim.g.have_nerd_font,
                content = {
                    --- Active window (inactive keeps the default) --------------------------
                    active = function()
                        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
                        local git = statusline.section_git { trunc_width = 40 }
                        local diff = statusline.section_diff { trunc_width = 75 }
                        local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
                        local lsp = statusline.section_lsp { trunc_width = 75 }
                        local filename = statusline.section_filename { trunc_width = 140 }
                        local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
                        local location = statusline.section_location { trunc_width = 75 }
                        local search = statusline.section_searchcount { trunc_width = 75 }
                        local formatter = function()
                            local format_enabled = true
                            if vim.g.disable_autoformat then
                                format_enabled = false
                            elseif vim.b.disable_autoformat then
                                format_enabled = false
                            end
                            if format_enabled then
                                return '󰝖 on'
                            else
                                return '󰝖 off'
                            end
                        end

                        local snippet_expand = function()
                            local glyph = '󰁌 '
                            if require('luasnip').config.enable_autosnippets then
                                return glyph .. 'on'
                            else
                                return glyph .. 'off'
                            end
                        end

                        return statusline.combine_groups {
                            { hl = mode_hl, strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                            '%<', -- Mark general truncate point
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=', -- End left alignment
                            { hl = 'MiniStatuslineFileinfo', strings = { formatter(), require('direnv').statusline(), fileinfo } },
                            { hl = mode_hl, strings = { search, location } },
                        }
                    end,
                },
            }

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return '%2l:%-2v'
            end

            -- Commenting
            require('mini.comment').setup()
            vim.keymap.set('i', '<c-/>', function()
                local line_num = vim.api.nvim_win_get_cursor(0)[1]
                MiniComment.toggle_lines(line_num, line_num)
            end, { desc = 'Toggle comment (insert mode)' })

            -- Bracket navigation
            require('mini.bracketed').setup {
                treesitter = { suffix = '' },
                file = { suffix = '' },
                buffer = { suffix = '' },
                oldfile = { suffix = '' },
            }
            vim.keymap.set('n', 'gb', function()
                require('mini.bracketed').buffer 'forward'
            end, { desc = 'Go to next buffer' })
            vim.keymap.set('n', 'gB', function()
                require('mini.bracketed').buffer 'backward'
            end, { desc = 'Go to next buffer' })

            -- File editing
            require('mini.files').setup()
            vim.keymap.set('n', '-', function()
                MiniFiles.open()
            end, { desc = 'Open MiniFiles editor.' })

            -- require('mini.misc').setup()
            require('mini.misc').setup_auto_root { '.git', 'Makefile', '.marksman.toml' }
            vim.keymap.set('n', '<leader>wm', function()
                require('mini.misc').zoom()
            end, { desc = 'Maximise buffer' })
            -- Autopair
            require('mini.pairs').setup()
            -- Create symmetrical `$$` pair only in Tex files
            local map_tex = function()
                MiniPairs.map_buf(0, 'i', '$', { action = 'closeopen', pair = '$$' })
            end
            vim.api.nvim_create_autocmd('FileType', { pattern = { 'tex', 'markdown' }, callback = map_tex })

            -- Splitjoin
            require('mini.splitjoin').setup()

            -- Move text
            require('mini.move').setup()

            -- -- Sessions
            -- require('mini.sessions').setup()
            -- vim.keymap.set('n', '<leader>ww', function()
            --     vim.ui.input({ prompt = 'Session Name' }, function(input)
            --         MiniSessions.write(input)
            --     end)
            -- end, { desc = 'Save session for auto session root dir' })
            -- vim.keymap.set('n', '<leader>wr', function()
            --     MiniSessions.select()
            -- end, { desc = 'Restore Session' })
            -- vim.keymap.set('n', '<leader>wd', function()
            --     MiniSessions.select 'delete'
            -- end, { desc = 'Delete Session' })
        end,
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'c',
                    'diff',
                    'html',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'vim',
                    'vimdoc',
                    'python',
                    'latex',
                    'yaml',
                },
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = {
                    enable = true,
                    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                    --  If you are experiencing weird indenting issues, add the language to
                    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                    additional_vim_regex_highlighting = { 'ruby' },
                    disable = { 'latex' },
                },
                indent = { enable = true, disable = { 'ruby' } },
            }
        end,
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    require 'kickstart.plugins.debug',
    require 'kickstart.plugins.indent_line',
    require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    { import = 'custom.plugins' },
    --
    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
