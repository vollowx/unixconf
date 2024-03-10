local map = vim.keymap.set

map({ 'n', 'x' }, '<Space>', '<Ignore>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- stylua: ignore start
map({ 'n', 'x' }, 'j', 'v:count ? "j" : "gj"', { expr = true })
map({ 'n', 'x' }, 'k', 'v:count ? "k" : "gk"', { expr = true })
map({ 'n', 'x' }, '<Down>', 'v:count ? "<Down>" : "g<Down>"', { expr = true, replace_keycodes = false })
map({ 'n', 'x' }, '<Up>',   'v:count ? "<Up>"   : "g<Up>"',   { expr = true, replace_keycodes = false })
map({ 'i' }, '<Down>', '<Cmd>norm! g<Down><CR>')
map({ 'i' }, '<Up>',   '<Cmd>norm! g<Up><CR>')
-- stylua: ignore end

map('n', '<Esc>', '<Cmd>noh<CR>')

map('n', 'K', vim.lsp.buf.hover)
map('n', 'gq;', vim.lsp.buf.format)
map({ 'n', 'x' }, '<Leader>r', vim.lsp.buf.rename)
map({ 'n', 'x' }, '<Leader>a', vim.lsp.buf.code_action)
