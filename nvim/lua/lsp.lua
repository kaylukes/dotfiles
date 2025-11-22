vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textdocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger=true})
        end
    end
})

vim.keymap.set({'n', 'i'}, '<C-A-l>', vim.lsp.buf.format)
vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'fuzzy'}
vim.keymap.set({'i'}, '<C-Space>', '<C-x><C-o>', {noremap = true, silent = true})
--vim.keymap.set("i", "<C-Space>", function()
 --   vim.lsp.buf.completion({})  -- triggers LSP completion manually
--end, { noremap = true, silent = true })
