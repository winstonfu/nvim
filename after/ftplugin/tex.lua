return {
    vim.cmd 'set linebreak',
    vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj'),
    vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk'),
    vim.keymap.set({ 'n', 'x', 'o' }, 'H', 'g0'),
    vim.keymap.set({ 'n', 'x', 'o' }, 'L', 'g$'),
}
