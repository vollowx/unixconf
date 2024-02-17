vim.keymap.set({ 'n', 'x' }, '<Space>', '<Ignore>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', 'H', '<Ignore>')
vim.keymap.set('n', 'L', '<Ignore>')

-- stylua: ignore start
vim.keymap.set({ 'n', 'x' }, 'j', 'v:count ? "j" : "gj"', { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'v:count ? "k" : "gk"', { expr = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'v:count ? "<Down>" : "g<Down>"', { expr = true, replace_keycodes = false })
vim.keymap.set({ 'n', 'x' }, '<Up>',   'v:count ? "<Up>"   : "g<Up>"',   { expr = true, replace_keycodes = false })
vim.keymap.set({ 'i' }, '<Down>', '<Cmd>norm! g<Down><CR>')
vim.keymap.set({ 'i' }, '<Up>',   '<Cmd>norm! g<Up><CR>')
-- stylua: ignore end

vim.keymap.set('n', ']b', '<Cmd>bnext<CR>')
vim.keymap.set('n', '[b', '<Cmd>bprevious<CR>')
vim.keymap.set('n', ']t', '<Cmd>tabnext<CR>')
vim.keymap.set('n', '[t', '<Cmd>tabprevious<CR>')

vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gq;', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'x' }, '<Leader>r', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'x' }, '<Leader>a', vim.lsp.buf.code_action)

vim.api.nvim_create_user_command('LspFormat', function()
  vim.lsp.buf.format()
end, {})
