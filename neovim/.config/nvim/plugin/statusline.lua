local statusline = {}
local H = {}

statusline.setup = function()
  _G.statusline = statusline
  vim.g.qf_disable_statusline = 1
  vim.go.statusline = '%!v:lua.statusline.active()'
  H.create_autocommands()
  H.create_default_hl()
end

statusline.active = function()
  return H.content()
end

--- Combine groups of sections
---
--- Each group can be either a string or a table with fields `hl` (group's
--- highlight group) and `strings` (strings representing sections).
---
--- General idea of this function is as follows;
--- - String group is used as is (useful for special strings like `%<` or `%=`).
--- - Each table group has own highlighting in `hl` field (if missing, the
---   previous one is used) and string parts in `strings` field. Non-empty
---   strings from `strings` are separated by one space. Non-empty groups are
---   separated by two spaces (one for each highlighting).
---
---@param groups table Array of groups.
---
---@return string String suitable for 'statusline'.
statusline.combine_groups = function(groups)
  local parts = vim.tbl_map(function(s)
    --stylua: ignore start
    if type(s) == 'string' then return s end
    if type(s) ~= 'table' then return '' end

    local string_arr = vim.tbl_filter(function(x) return type(x) == 'string' and x ~= '' end, s.strings or {})
    local str = table.concat(string_arr, ' ')

    -- Use previous highlight group
    if s.hl == nil then
      return (' %s '):format(str)
    end

    -- Allow using this highlight group later
    if str:len() == 0 then
      return string.format('%%#%s#', s.hl)
    end

    return string.format('%%#%s# %s ', s.hl, str)
    --stylua: ignore end
  end, groups)

  return table.concat(parts, '')
end

statusline.is_truncated = function(trunc_width)
  -- Use -1 to default to 'not truncated'
  local cur_width = vim.o.laststatus == 3 and vim.o.columns
    or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

statusline.section_mode = function()
  local mode_info = H.modes[vim.fn.mode()]

  local mode = mode_info[1]

  return mode, mode_info.hl
end

statusline.section_git = function(args)
  if H.isnt_normal_buffer() then
    return ''
  end

  local head = vim.b.gitsigns_head or '-'
  local signs = statusline.is_truncated(args.trunc_width) and ''
    or (vim.b.gitsigns_status or '')
  local icon = vim.trim(icons.ui.Branch)

  if signs == '' then
    if head == '-' or head == '' then
      return ''
    end
    return string.format('%s %s', icon, head)
  end
  return string.format('%s %s %s', icon, head, signs)
end

statusline.section_diagnostics = function(args)
  local dont_show = statusline.is_truncated(args.trunc_width)
    or H.isnt_normal_buffer()
    or H.has_no_lsp_attached()
  if dont_show or H.diagnostic_is_disabled() then
    return ''
  end

  -- Construct string parts
  local count = H.diagnostic_get_count()
  local severity, t = vim.diagnostic.severity, {}
  for _, level in ipairs(H.diagnostic_levels) do
    local n = count[severity[level.name]] or 0
    -- Add level info only if diagnostic is present
    if n > 0 then
      table.insert(t, string.format('%s%s', level.sign, n))
    end
  end

  if vim.tbl_count(t) == 0 then
    return ''
  end
  return table.concat(t, ' ')
end

statusline.section_filename = function(args)
  -- In terminal always use plain name
  if vim.bo.buftype == 'terminal' then
    return '%t'
  elseif statusline.is_truncated(args.trunc_width) then
    -- File name with 'truncate', 'modified', 'readonly' flags
    -- Use relative path if truncated
    return '%f%m%r'
  else
    -- Use fullpath if not truncated
    return '%F%m%r'
  end
end

statusline.section_fileinfo = function(args)
  local filetype = vim.bo.filetype

  -- Don't show anything if can't detect file type or not inside a "normal
  -- buffer"
  if (filetype == '') or H.isnt_normal_buffer() then
    return ''
  end

  -- Construct output string if truncated
  if statusline.is_truncated(args.trunc_width) then
    return filetype
  end

  -- Construct output string with extra file info
  local encoding = vim.bo.fileencoding or vim.bo.encoding
  local format = vim.bo.fileformat

  return string.format('%s %s[%s]', filetype, encoding, format)
end

statusline.section_location = function()
  return '%l:%2v'
end

statusline.section_searchcount = function(args)
  if vim.v.hlsearch == 0 or statusline.is_truncated(args.trunc_width) then
    return ''
  end
  -- `searchcount()` can return errors because it is evaluated very often in
  -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
  local ok, s_count =
    pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then
    return ''
  end

  if s_count.incomplete == 1 then
    return '?/?'
  end

  local too_many = ('>%d'):format(s_count.maxcount)
  local current = s_count.current > s_count.maxcount and too_many
    or s_count.current
  local total = s_count.total > s_count.maxcount and too_many or s_count.total
  return ('%s/%s'):format(current, total)
end

H.diagnostic_levels = {
  { name = 'ERROR', sign = icons.diagnostics.DiagnosticSignError },
  { name = 'WARN', sign = icons.diagnostics.DiagnosticSignWarn },
  { name = 'INFO', sign = icons.diagnostics.DiagnosticSignInfo },
  { name = 'HINT', sign = icons.diagnostics.DiagnosticSignHint },
}

-- Count of attached LSP clients per buffer id
H.n_attached_lsp = {}

H.create_autocommands = function()
  local augroup = vim.api.nvim_create_augroup('Statusline', {})

  local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(
      event,
      { group = augroup, pattern = pattern, callback = callback, desc = desc }
    )
  end

  local make_track_lsp = function(increment)
    return function(data)
      H.n_attached_lsp[data.buf] = (H.n_attached_lsp[data.buf] or 0)
        + increment
    end
  end
  au('LspAttach', '*', make_track_lsp(1), 'Track LSP clients')
  au('LspDetach', '*', make_track_lsp(-1), 'Track LSP clients')
end

--stylua: ignore
H.create_default_hl = function()
  local set_default_hl = function(name, data)
    data.default = true
    vim.api.nvim_set_hl(0, name, data)
  end

  set_default_hl('StatuslineModeNormal',  { link = 'Cursor' })
  set_default_hl('StatuslineModeInsert',  { link = 'DiffChange' })
  set_default_hl('StatuslineModeVisual',  { link = 'DiffAdd' })
  set_default_hl('StatuslineModeReplace', { link = 'DiffDelete' })
  set_default_hl('StatuslineModeCommand', { link = 'DiffText' })
  set_default_hl('StatuslineModeOther',   { link = 'IncSearch' })

  set_default_hl('StatuslineDevinfo',  { link = 'StatusLine' })
  set_default_hl('StatuslineFilename', { link = 'StatusLineNC' })
  set_default_hl('StatuslineFileinfo', { link = 'StatusLine' })
end

-- Custom `^V` and `^S` symbols to make this file appropriate for copy-paste
-- (otherwise those symbols are not displayed).
local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

-- stylua: ignore start
H.modes = setmetatable({
  ['n']    = { 'NOR', hl = 'StatuslineModeNormal' },
  ['v']    = { 'VIS', hl = 'StatuslineModeVisual' },
  ['V']    = { 'VLN', hl = 'StatuslineModeVisual' },
  [CTRL_V] = { 'VBL', hl = 'StatuslineModeVisual' },
  ['s']    = { 'SEL', hl = 'StatuslineModeVisual' },
  ['S']    = { 'SLN', hl = 'StatuslineModeVisual' },
  [CTRL_S] = { 'SBL', hl = 'StatuslineModeVisual' },
  ['i']    = { 'INS', hl = 'StatuslineModeInsert' },
  ['R']    = { 'REP', hl = 'StatuslineModeReplace' },
  ['c']    = { 'COM', hl = 'StatuslineModeCommand' },
  ['r']    = { 'PRO', hl = 'StatuslineModeOther' },
  ['!']    = { 'SHE', hl = 'StatuslineModeOther' },
  ['t']    = { 'TER', hl = 'StatuslineModeOther' },
}, {
  __index = function()
    return   { '???', hl = '%#StatuslineModeOther#' }
  end,
})
-- stylua: ignore end

H.content = function()
  -- stylua: ignore start
  local mode, mode_hl = statusline.section_mode()
  local git           = statusline.section_git({ trunc_width = 75 })
  local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
  local filename      = statusline.section_filename({ trunc_width = 140 })
  local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
  local location      = statusline.section_location()
  local search        = statusline.section_searchcount({ trunc_width = 75 })

  return statusline.combine_groups({
    { hl = mode_hl,              strings = { mode } },
    { hl = 'StatuslineDevinfo',  strings = { git, diagnostics } },
    '%<', -- Mark general truncate point
    { hl = 'StatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'StatuslineFileinfo', strings = { fileinfo } },
    { hl = mode_hl,              strings = { search, location } },
  })
  -- stylua: ignore end
end

H.isnt_normal_buffer = function()
  -- For more information see ":h buftype"
  return vim.bo.buftype ~= ''
end

H.has_no_lsp_attached = function()
  return (H.n_attached_lsp[vim.api.nvim_get_current_buf()] or 0) == 0
end

H.diagnostic_get_count = function()
  return vim.diagnostic.count(0)
end

H.diagnostic_is_disabled = function()
  return vim.diagnostic.is_disabled(0)
end

statusline.setup()
