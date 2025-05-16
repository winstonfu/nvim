return {
    vim.keymap.set('n', '<leader>e', function()
        vim.cmd 'w'
        vim.cmd('OverseerRunCmd python3 "' .. vim.fn.expand '%:p' .. '"')
        vim.cmd 'OverseerOpen! bottom'
    end, { desc = '[E]xecute Code' }),
    vim.keymap.set('n', '<leader>to', '<cmd>OverseerToggle!<cr>', { silent = true, desc = '[T]oggle [O]verseer Panel' }),
    vim.keymap.set('n', '<leader>ct', '<cmd>OverseerToggle!<cr>', { silent = true, desc = 'Overseer [T]oggle Panel' }),
    vim.keymap.set('n', '<leader>co', '<cmd>OverseerOpen<cr>', { silent = true, desc = 'Overseer [O]pen Panel' }),
}
