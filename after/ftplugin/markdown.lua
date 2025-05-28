local set_text = function()
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 1
end

return {
    vim.diagnostic.enable(false, { bufnr = 0 }),
    set_text(),
    vim.keymap.set(
        'n',
        '<leader>zl',
        '<cmd>s/\\v((\\[)@<!\\@([A-Z|0-9]{8})#[A-Z|a-z|+|\\-|0-9|_]+)/[\\1](zotero:\\/\\/select\\/items\\/0_\\2)<cr><esc>',
        { desc = 'Convert Zotero Citekey to Markdown Link', buffer = true }
    ),
    vim.keymap.set(
        'n',
        '<leader>zL',
        '<cmd>%s/\\v((\\[)@<!\\@([A-Z|0-9]{8})#[A-Z|a-z|+|\\-|0-9|_]+)/[\\1](zotero:\\/\\/select\\/items\\/0_\\2)<cr><esc>',
        { desc = 'Convert Zotero Citekey to Markdown Link (Entire File)', buffer = true }
    ),

    vim.keymap.set('n', '<leader>zz', '<cmd>Zselectannotations<cr>', { desc = 'Insert annotations from Zotero', buffer = true }),
}
