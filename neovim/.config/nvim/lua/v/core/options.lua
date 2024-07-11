local o = vim.opt
local g = vim.g

-- stylua: ignore start
o.autowriteall   = true
o.breakindent    = true
o.completeopt    = 'menuone,noselect,popup'
o.cursorline     = true
o.cursorlineopt  = 'both'
o.foldexpr       = 'nvim_treesitter#foldexpr()'
o.foldlevelstart = 99
o.foldmethod     = 'expr'
o.foldtext       = ''
o.grepprg        = 'rg --hidden --vimgrep --smart-case --'
o.guifont        = 'monospace:h12'
o.helpheight     = 10
o.jumpoptions    = 'stack'
o.mousemoveevent = true
o.number         = true
o.pumheight      = 16
o.scrolloff      = 5
o.showcmd        = false
o.showmode       = false
o.sidescrolloff  = 5
o.signcolumn     = 'yes:1'
o.splitright     = true
o.splitbelow     = true
o.swapfile       = false
o.undofile       = true
o.updatetime     = 100
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
  o.listchars:append({ nbsp = '·' })
  o.fillchars:append({
    foldopen = '',
    foldclose = '',
    diff = '╱',
  })
end

-- stylua: ignore start
o.ts          = 2
o.softtabstop = 2
o.shiftwidth  = 2
o.expandtab   = true
o.smartindent = true
o.autoindent  = true

o.ignorecase  = true
o.smartcase   = true
-- stylua: ignore end

if vim.g.neovide then
  g.neovide_padding_top = 16
  g.neovide_padding_bottom = 16
  g.neovide_padding_right = 16
  g.neovide_padding_left = 16
  g.neovide_floating_shadow = false
  g.neovide_scale_factor = 1.0
end
