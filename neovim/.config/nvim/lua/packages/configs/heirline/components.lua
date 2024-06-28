local conds = require('heirline.conditions')

local M = {}

M.spacer = { provider = '%=' }

M.padding = function(n)
  return { provider = string.rep(' ', n) }
end

M.pos = {
  provider = '%{%&ru?"%l:%c ":""%}',
}

M.mode = function()
  return {
    init = function(self)
      self.mode = vim.fn.mode()

      if not self.once then
        vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:*o', command = 'redrawstatus' })
        self.once = true
      end
    end,
    static = {
      mode_labels = {
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
      return conds.is_active() and (' ' .. self.mode_labels[self.mode] .. ' ') or '    '
    end,
    hl = function()
      return { fg = 'purple', bg = conds.is_active() and 'surface_bg' or 'bg', bold = true }
    end,
    update = { 'ModeChanged', 'WinEnter' },
  }
end

M.filepath = {
  provider = function()
    if vim.bo.filetype == 'oil' then
      return require('oil').get_current_dir()
    end

    if vim.bo.filetype == 'lazy' then
      return 'Packages'
    end

    if vim.bo.filetype == 'lspinfo' then
      return 'LSP Servers'
    end

    return '%t'
  end,
  hl = function()
    return { bold = conds.is_active() }
  end,
}

M.file_flags = {
  condition = function()
    return vim.bo.buftype == ''
  end,
  {
    condition = function()
      local filename = vim.fn.expand('%')
      return filename ~= '' and vim.bo.buftype == '' and vim.fn.filereadable(filename) == 0
    end,
    provider = ' [New]',
  },
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' [+]',
  },
  {
    condition = function()
      return vim.bo.modifiable == false
    end,
    provider = ' [-]',
  },
  {
    condition = function()
      return vim.bo.binary
    end,
    provider = ' [BIN]',
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' [RO]',
  },
}

M.lsp = {
  provider = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
      return ''
    end

    local client_names = {}
    local excluded_clients = {
      copilot = true,
    }
    for _, client in pairs(clients) do
      if not excluded_clients[client.name] then
        table.insert(client_names, client.name)
      end
    end

    return string.format('[%s]', table.concat(client_names, ', '))
  end,
}

M.lsp_message = {}

M.diag = {
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { 'DiagnosticChanged', 'BufEnter' },

  {
    provider = '[',
  },
  {
    provider = function(self)
      return self.errors .. ' '
    end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self)
      return self.warnings .. ' '
    end,
    hl = { fg = 'diag_warn' },
  },
  {
    provider = function(self)
      return self.info .. ' '
    end,
    hl = { fg = 'diag_info' },
  },
  {
    provider = function(self)
      return self.hints
    end,
    hl = { fg = 'diag_hint' },
  },
  {
    provider = ']',
  },
}

M.git = {
  condition = conds.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  {
    provider = function(self)
      return self.status_dict.head
    end,
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count)
    end,
    hl = { fg = 'git_add' },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count)
    end,
    hl = { fg = 'git_del' },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count)
    end,
    hl = { fg = 'git_change' },
  },
}

return M
