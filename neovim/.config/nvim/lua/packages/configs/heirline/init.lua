local heirline = require('heirline')
local utils = require('heirline.utils')

local hl = utils.get_highlight

local function load_colors()
  return {
    bg = hl('StatusLine').bg,
    fg = hl('StatusLine').fg,
    fg_nc = hl('StatusLineNC').fg,
    surface_bg = hl('CursorLine').bg,

    red = hl('DiagnosticError').fg,
    green = hl('String').fg,
    blue = hl('Function').fg,
    gray = hl('NonText').fg,
    orange = hl('Constant').fg,
    purple = hl('Statement').fg,
    cyan = hl('Special').fg,
    yellow = hl('DiagnosticWarn').fg,

    diag_warn = hl('DiagnosticWarn').fg,
    diag_error = hl('DiagnosticError').fg,
    diag_hint = hl('DiagnosticHint').fg,
    diag_info = hl('DiagnosticInfo').fg,

    git_del = hl('GitSignsDelete').fg,
    git_add = hl('GitSignsAdd').fg,
    git_change = hl('GitSignsChange').fg,
  }
end

heirline.setup({
  statusline = require('packages.configs.heirline.statusline'),
})

utils.on_colorscheme(load_colors)

vim.api.nvim_create_augroup('Heirline', { clear = true })
vim.api.nvim_create_autocmd('colorscheme', {
  callback = function()
    utils.on_colorscheme(load_colors)
  end,
  group = 'Heirline',
})
