local o = vim.opt
local g = vim.g

-- stylua: ignore start
o.autowriteall   = true
o.breakindent    = true
o.completeopt    = 'menuone'
o.cursorline     = true
o.cursorlineopt  = 'number'
o.foldcolumn     = settings.ui.display_fold and 'auto' or '0'
o.foldexpr       = 'nvim_treesitter#foldexpr()'
o.foldlevelstart = 99
o.foldmethod     = 'expr'
o.foldtext       = ''
o.formatexpr     = 'v:lua.vim.lsp.formatexpr()'
o.helpheight     = 10
o.jumpoptions    = 'stack'
o.laststatus     = 3
o.number         = settings.number ~= 'hidden'
o.pumheight      = 16
o.relativenumber = settings.number == 'relative'
o.scrolloff      = settings.scrolloff
o.showmode       = false
o.sidescrolloff  = 5
o.signcolumn     = 'yes:1'
o.splitright     = true
o.splitbelow     = true
o.swapfile       = false
o.undofile       = true
o.wrap           = false
-- stylua: ignore end

o.backup = true
o.backupdir:remove('.')

o.clipboard:append('unnamedplus')

o.diffopt:append({
  'algorithm:histogram',
  'indent-heuristic',
})

o.gcr = {
  'i-c-ci-ve:blinkoff500-blinkon500-block-TermCursor',
  'n-v:block-Curosr/lCursor',
  'o:hor50-Curosr/lCursor',
  'r-cr:hor20-Curosr/lCursor',
}

o.shortmess:append('I')

o.list = true
o.listchars = {
  tab = '→ ',
  trail = '·',
}
o.fillchars = {
  fold = ' ',
  foldsep = ' ',
  eob = ' ',
}

if g.has_gui then
  o.listchars:append({ nbsp = '␣' })
  o.fillchars:append({
    foldopen = vim.trim(icons.ui.AngleDown),
    foldclose = vim.trim(icons.ui.AngleRight),
    diff = '╱',
  })
end

-- stylua: ignore start
o.ts          = settings.editor.tab_size
o.softtabstop = settings.editor.tab_size
o.shiftwidth  = settings.editor.tab_size
o.expandtab   = true
o.smartindent = true
o.autoindent  = true

o.ignorecase  = true
o.smartcase   = true
-- stylua: ignore end
