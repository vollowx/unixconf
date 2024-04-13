local modes = {
  n = '  ',
  t = '  ',
  no = '  ',
  v = '**',
  V = '**',
  ['\22'] = '**',
  s = '[]',
  S = '[]',
  ['\19'] = '[]',
  i = '**',
  ic = '**',
  R = '~~',
  Rv = '~~',
  c = '::',
  cv = '::',
  ce = '::',
  r = '??',
  rm = '??',
  ['r?'] = '??',
}

local function get_mode()
  local function get_mode_color()
    local mode = vim.api.nvim_get_mode().mode
    local mode_color = '%#NormalNC#'

    if (mode == 'i') or (mode == 'ic') then
      mode_color = '%#StatuslineInsert#'
    elseif ((mode == 'v') or (mode == 'V')) or (mode == '\22') then
      mode_color = '%#StatuslineVisual#'
    elseif mode == 'R' then
      mode_color = '%#StatuslineReplace#'
    elseif mode == 'c' then
      mode_color = '%#StatuslineCommand#'
    else
    end

    return mode_color
  end

  return get_mode_color()
    .. string.format(' %s ', modes[vim.api.nvim_get_mode().mode])
end
local function get_lsp_diagnostic()
  local function get(s)
    return #vim.diagnostic.get(0, { severity = s })
  end
  local result = {
    errors = get(vim.diagnostic.severity.ERROR),
    warnings = get(vim.diagnostic.severity.WARN),
    info = get(vim.diagnostic.severity.INFO),
    hints = get(vim.diagnostic.severity.HINT),
  }
  local output = {
    result.errors == 0 and ''
      or string.format('%%#StatuslineDiagnosticError#%s ', result.errors),
    result.warnings == 0 and ''
      or string.format('%%#StatuslineDiagnosticWarn#%s ', result.warnings),
    result.info == 0 and ''
      or string.format('%%#StatuslineDiagnosticInfo#%s ', result.info),
    result.info == 0 and ''
      or string.format('%%#StatuslineDiagnosticHints#%s ', result.hints),
  }
  return table.concat(output)
end
local function get_git_branch()
  local branch = (vim.b.gitsigns_status_dict or { head = '' })
  local is_head_empty = (branch.head ~= '')
  return (
    (
      is_head_empty
      and string.format('%%#StatuslineGitBranch##%s ', (branch.head or ''))
    ) or ''
  )
end
local function get_location()
  return '%#Statusline#%l:%c '
end

_G.statusline = {}
statusline.get = function()
  return table.concat({
    get_mode(),
    '%#NormalNC#',
    '%=',
    '%#Statusline# ',
    get_lsp_diagnostic(),
    get_git_branch(),
    get_location(),
  })
end

vim.g.qf_disable_statusline = 1
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.statusline = [[%!v:lua.statusline.get()]]
