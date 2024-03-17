local modes = {
  n = 'RW',
  no = 'RO',
  v = '**',
  V = '**',
  ['\22'] = '**',
  s = 'S',
  S = 'SL',
  ['\19'] = 'SB',
  i = '**',
  ic = '**',
  R = 'RA',
  Rv = 'RV',
  c = 'CO',
  cv = 'CO',
  ce = 'VX',
  r = 'r',
  rm = 'r',
  ['r?'] = 'r',
  ['!'] = '!',
  t = '\239\132\160',
}

local function get_filetype()
  return ('%#NormalNC#' .. vim.bo.filetype)
end
local function get_bufnr()
  return ('%#Comment#' .. vim.api.nvim_get_current_buf())
end
local function color()
  local mode = vim.api.nvim_get_mode().mode
  local mode_color = '%#Normal#'
  if mode == 'n' then
    mode_color = '%#StatusNormal#'
  elseif (mode == 'i') or (mode == 'ic') then
    mode_color = '%#StatusInsert#'
  elseif ((mode == 'v') or (mode == 'V')) or (mode == '\22') then
    mode_color = '%#StatusVisual#'
  elseif mode == 'R' then
    mode_color = '%#StatusReplace#'
  elseif mode == 'c' then
    mode_color = '%#StatusCommand#'
  elseif mode == 't' then
    mode_color = '%#StatusTerminal#'
  else
  end
  return mode_color
end
local function get_fileinfo()
  local filename = string.format(
    ' %s ',
    (vim.fn.expand('%') == '') and 'F L A K E' or vim.fn.expand('%:t')
  )
  return ('%#Normal#' .. filename .. '%#NormalNC#')
end
local function get_git_status()
  local branch = (vim.b.gitsigns_status_dict or { head = '' })
  local is_head_empty = (branch.head ~= '')
  return (
    (is_head_empty and string.format('(λ • #%s) ', (branch.head or '')))
    or ''
  )
end
local function get_lsp_diagnostic()
  if not rawget(vim, 'lsp') then
    return ''
  else
  end
  local function get_severity(s)
    return #vim.diagnostic.get(0, { severity = s })
  end
  local result = {
    errors = get_severity(vim.diagnostic.severity.ERROR),
    warnings = get_severity(vim.diagnostic.severity.WARN),
    info = get_severity(vim.diagnostic.severity.INFO),
    hints = get_severity(vim.diagnostic.severity.HINT),
  }
  return string.format(
    ' %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s ',
    (result.warnings or 0),
    (result.errors or 0)
  )
end
local function get_location()
  return '%#Normal# %l:%c '
end

_G.statusline = {}
statusline.get = function()
  return table.concat({
    color(),
    string.format(' %s ', modes[vim.api.nvim_get_mode().mode]):upper(),
    get_fileinfo(),
    get_git_status(),
    get_bufnr(),
    '%=',
    get_lsp_diagnostic(),
    get_filetype(),
    get_location(),
  })
end

vim.g.qf_disable_statusline = 1
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.statusline = [[%!v:lua.statusline.get()]]
