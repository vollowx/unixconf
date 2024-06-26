local M = {}

M.spacer = { provider = '%=' }

M.padding = function(n)
  return { provider = string.rep(' ', n) }
end

M.mode = function()
  return {
    init = function(self)
      self.mode = vim.fn.mode()

      if not self.once then
        vim.api.nvim_create_autocmd(
          'ModeChanged',
          { pattern = '*:*o', command = 'redrawstatus' }
        )
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
      mode_colors = {
        n = 'blue',
        i = 'green',
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
    provider = function(self)
      return ' ' .. self.mode_labels[self.mode] .. ' '
    end,
    hl = function(self)
      return { fg = self.mode_colors[self.mode], bg = 'surface_bg' }
    end,
    update = { 'ModeChanged' },
  }
end

M.filepath = {
  provider = function()
    if vim.bo.filetype == 'lazy' then
      return 'Package Manager'
    end

    if vim.bo.filetype == 'lspinfo' then
      return 'LSP Information'
    end

    return '%t'
  end,
}

M.file_flags = {
  condition = function()
    return vim.bo.buftype == ''
  end,
  {
    condition = function()
      local filename = vim.fn.expand('%')
      return filename ~= ''
        and vim.bo.buftype == ''
        and vim.fn.filereadable(filename) == 0
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

    return string.format(' [%s]', table.concat(client_names, ', '))
  end,
}

M.pos = {
  provider = '%{%&ru?"%l:%c ":""%}',
}

return M
