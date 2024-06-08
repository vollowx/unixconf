local conditions = require('heirline.conditions')
local heirline = require('heirline')
local utils = require('heirline.utils')

local function load_colors()
  return {
    bg = utils.get_highlight('StatusLine').bg,
    fg = utils.get_highlight('StatusLine').fg,
    surface_bg = utils.get_highlight('CursorLine').bg,

    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    green = utils.get_highlight('String').fg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    orange = utils.get_highlight('Constant').fg,
    purple = utils.get_highlight('Statement').fg,
    cyan = utils.get_highlight('Special').fg,

    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,

    git_del = utils.get_highlight('diffDeleted').fg,
    git_add = utils.get_highlight('diffAdded').fg,
    git_change = utils.get_highlight('diffChanged').fg,
  }
end

local Padding = function(n)
  return { provider = string.rep(' ', n) }
end

local Mode = function(icon)
  return {
    init = function(self)
      self.mode = vim.fn.mode(1)

      if not self.once then
        vim.api.nvim_create_autocmd(
          'ModeChanged',
          { pattern = '*:*o', command = 'redrawstatus' }
        )
        self.once = true
      end
    end,
    static = {
      mode_colors = {
        n = 'green',
        i = 'blue',
        v = 'purple',
        [''] = 'purple',
        V = 'purple',
        c = 'orange',
        no = 'red',
        s = 'orange',
        S = 'orange',
        [''] = 'orange',
        ic = 'yellow',
        R = 'red',
        Rv = 'red',
        cv = 'red',
        ce = 'red',
        r = 'red',
        rm = 'red',
        ['r?'] = 'cyan',
        ['!'] = 'red',
        t = 'yellow',
      },
    },
    provider = function()
      return icon
    end,
    hl = function(self)
      return { fg = self.mode_colors[self.mode] }
    end,
    update = { 'ModeChanged' },
  }
end

local FileSize = {
  provider = function()
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return fsize .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))

    return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
  end,
}

local FileLines = {
  provider = '%4L',
}

local FileIcon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(
      filename,
      extension,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FilePath = {
  provider = function()
    local filepath = vim.fn.expand('%:.')

    if filepath == '' then
      return '[No Name]'
    end

    if not conditions.width_percent_below(#filepath, 0.25) then
      filepath = vim.fn.pathshorten(filepath)
    end

    return filepath
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = 'red', force = true, bold = false }
    else
      return { fg = 'purple' }
    end
  end,
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.binary
    end,
    provider = '  ',
    hl = { fg = 'blue' },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' 󰍁 ',
    hl = { fg = 'orange' },
  },
}

local Ruler = {
  provider = '%5(%3l:%-2c%)',
}

local ScrollBar = {
  static = {
    sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'diag_info', bg = 'surface_bg' },
}

local spacer = { provider = '%=' }

local left = {
  Mode(' ' .. icons.ui.CircleFilled),
  Padding(2),
  FileSize,
  Padding(2),
  FileIcon,
  FilePath,
  FileFlags,
  Padding(2),
  FileLines,
  Padding(2),
  Ruler,
  Padding(3),
  ScrollBar,
}

local center = {}

local right = {}

heirline.setup({
  statusline = {
    Mode('▉ '),
    left,
    spacer,
    center,
    spacer,
    right,
    Mode(' ▉'),
    hl = {
      bg = 'bg',
      fg = 'fg',
    },
  },
})

utils.on_colorscheme(load_colors)

vim.api.nvim_create_augroup('Heirline', { clear = true })
vim.api.nvim_create_autocmd('colorscheme', {
  callback = function()
    utils.on_colorscheme(load_colors)
  end,
  group = 'Heirline',
})

vim.opt.laststatus = 3
