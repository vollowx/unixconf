local colors = require('catppuccin.palettes').get_palette()
local conditions = require('heirline.conditions')
local heirline = require('heirline')
local utils = require('heirline.utils')

conditions.buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

conditions.hide_in_width = function(size)
  return vim.api.nvim_get_option_value('columns', { scope = 'local' })
    > (size or 140)
end

local align = { provider = '%=' }
local space = { provider = ' ' }

local mode = {
  {
    init = function(self)
      self.mode = vim.api.nvim_get_mode().mode
      if not self.once then
        vim.api.nvim_create_autocmd('ModeChanged', {
          pattern = '*:*o',
          command = 'redrawstatus',
        })
        self.once = true
      end
    end,
    static = {
      modes = {
        ['n'] = 'NO',
        ['no'] = 'OP',
        ['nov'] = 'OC',
        ['noV'] = 'OL',
        ['no\x16'] = 'OB',
        ['\x16'] = 'VB',
        ['niI'] = 'IN',
        ['niR'] = 'RE',
        ['niV'] = 'RV',
        ['nt'] = 'NT',
        ['ntT'] = 'TM',
        ['v'] = 'VI',
        ['vs'] = 'VI',
        ['V'] = 'VL',
        ['Vs'] = 'VL',
        ['\x16s'] = 'VB',
        ['s'] = 'SE',
        ['S'] = 'SL',
        ['\x13'] = 'SB',
        ['i'] = 'IN',
        ['ic'] = 'IC',
        ['ix'] = 'IX',
        ['R'] = 'RE',
        ['Rc'] = 'RC',
        ['Rx'] = 'RX',
        ['Rv'] = 'RV',
        ['Rvc'] = 'RC',
        ['Rvx'] = 'RX',
        ['c'] = 'CO',
        ['cv'] = 'CV',
        ['r'] = 'PR',
        ['rm'] = 'PM',
        ['r?'] = 'P?',
        ['!'] = 'SH',
        ['t'] = 'TE',
      },
    },
    provider = function(self)
      local mode = self.mode
      local mode_str = (mode == 'n' and (vim.bo.ro or not vim.bo.ma)) and 'RO'
        or self.modes[mode]
      return (' %s '):format(mode_str)
    end,
    hl = function()
      return {
        fg = vim.bo.modified and colors.rosewater or colors.mauve,
        bg = colors.surface1,
        bold = true,
      }
    end,
    update = { 'ModeChanged', 'BufModifiedSet' },
  },
  {
    provider = '',
    hl = { fg = colors.surface1, bg = colors.surface0 },
  },
}

local file_name = {
  {
    provider = function()
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
      if not conditions.width_percent_below(#filename, 0.25) then
        filename = vim.fn.pathshorten(filename)
      end
      return filename == '' and '' or (' %s '):format(filename)
    end,
    hl = { bg = colors.surface0 },
  },
  {
    provider = '',
    hl = { fg = colors.surface0, bg = colors.mantle },
  },
}

local git_status = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,
  {
    provider = function(self)
      return ('#%s'):format(
        self.status_dict.head == '' and '~' or self.status_dict.head
      )
    end,
    hl = { fg = colors.overlay0 },
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+%s'):format(count)
    end,
    hl = { fg = colors.green },
    condition = function()
      return conditions.buffer_not_empty() and conditions.hide_in_width()
    end,
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~%s'):format(count)
    end,
    hl = { fg = colors.peach },
    condition = function()
      return conditions.buffer_not_empty() and conditions.hide_in_width()
    end,
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-%s'):format(count)
    end,
    hl = { fg = colors.red },
    condition = function()
      return conditions.buffer_not_empty() and conditions.hide_in_width()
    end,
  },
}

local diagnostics = {
  static = {
    error_icon = icons.diagnostics.DiagnosticSignError,
    warn_icon = icons.diagnostics.DiagnosticSignWarn,
    info_icon = icons.diagnostics.DiagnosticSignInfo,
    hint_icon = icons.diagnostics.DiagnosticSignHint,
  },

  init = function(self)
    self.errors =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { 'DiagnosticChanged', 'BufEnter' },

  {
    condition = function(self)
      return self.errors > 0
    end,
    {
      provider = function(self)
        return self.error_icon
      end,
      hl = { fg = colors.red },
    },
    {
      provider = function(self)
        return self.errors .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.warnings > 0
    end,
    {
      provider = function(self)
        return self.warn_icon
      end,
      hl = { fg = colors.yellow },
    },
    {
      provider = function(self)
        return self.warnings .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.info > 0
    end,
    {
      provider = function(self)
        return self.info_icon
      end,
      hl = { fg = colors.blue },
    },
    {
      provider = function(self)
        return self.info .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.hints > 0
    end,
    {
      provider = function(self)
        return self.hint_icon
      end,
      hl = { fg = colors.teal },
    },
    {
      provider = function(self)
        return self.hints .. ' '
      end,
    },
  },

  on_click = {
    name = 'heirline_diagnostics',
    callback = function()
      vim.cmd.Telescope('diagnostics')
    end,
  },
}

local lsp = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return table.concat(names, ' ')
  end,
  hl = { fg = colors.blue },

  on_click = {
    name = 'heirline_lsp',
    callback = function()
      vim.cmd.LspInfo()
    end,
  },
}

vim.opt.showcmdloc = 'statusline'
local show_cmd = {
  provider = '%3.5(%S%) ',
  hl = 'StatusLineCmd',
}

local ruler = {
  provider = '%l:%c',
}

heirline.setup({
  statusline = {
    hl = { fg = colors.text, bg = colors.mantle },
    mode,
    file_name,
    space,
    git_status,
    align,
    show_cmd,
    diagnostics,
    lsp,
    space,
    ruler,
    space,
  },
})

local groupid = vim.api.nvim_create_augroup('Heirline', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = groupid,
  callback = utils.on_colorscheme,
})
