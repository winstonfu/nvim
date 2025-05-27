return {
    vim.keymap.set('n', '<leader>e', function()
        vim.cmd 'w'
        vim.cmd('OverseerRunCmd python3 "' .. vim.fn.expand '%:p' .. '"')
        vim.cmd 'OverseerOpen! bottom'
    end, { desc = '[E]xecute Code', buffer = true }),
    vim.keymap.set('n', '<leader>to', '<cmd>OverseerToggle!<cr>', { silent = true, desc = '[T]oggle [O]verseer Panel', buffer = true }),
    vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle!<cr>', { silent = true, desc = 'Overseer [T]oggle Panel', buffer = true }),
    vim.keymap.set('n', '<leader>oo', '<cmd>OverseerOpen<cr>', { silent = true, desc = 'Overseer [O]pen Panel', buffer = true }),
}
