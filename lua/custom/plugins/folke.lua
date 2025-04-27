return {
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
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@type Flash.Config
        opts = {},
      -- stylua: ignore
      keys = {
        { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "<S-CR>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search({remote_op = { restore = true, motion = true, }, }) end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
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
            dashboard = {
                enabled = true,
                preset = {
                    header = [[
   _____
  /     \
  vvvvvvv  /|__/|
    I   /O,O   |
               I /_____   |      /|/|
                      J|/^ ^ ^ \  |    /00  |    _//|
                       |^ ^ ^ ^ |w|   |/^^\ |   /oo |
                        \m___m__|_|    \m_m_|   \mm_|
                        ]],
                },
                sections = {
                    { section = 'header' },
                    { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
                    { section = 'startup' },
                },
            },
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
            scratch = {
                enabled = true,
                win_by_ft = {
                    python = {
                        keys = {
                            ['source'] = {
                                '<c-cr>',
                                function(self)
                                    local name = 'scratch.' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ':e')
                                    vim.cmd 'w !python'
                                end,
                                desc = 'Source buffer',
                                mode = { 'n', 'x' },
                            },
                        },
                    },
                },
            },
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
            {
                '<leader>wn',
                function()
                    Snacks.notifier.show_history()
                end,
                desc = 'Show [N]otification History',
            },
            {
                '<leader>.',
                function()
                    Snacks.scratch()
                end,
                desc = 'Toggle Scratch Buffer',
            },
            {
                '<leader>S',
                function()
                    Snacks.scratch.select()
                end,
                desc = 'Select Scratch Buffer',
            },
        },
    },
}
