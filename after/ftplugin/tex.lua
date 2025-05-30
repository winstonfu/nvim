local set_text = function()
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 1
end
return {
    set_text(),
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'j', 'gj'),
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'k', 'gk'),
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'H', 'g0'),
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'L', 'g$'),
}
