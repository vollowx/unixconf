local M = {}

M.spacer = { provider = '%=' }

M.padding = function(n)
  return { provider = string.rep(' ', n) }
end

M.mode = function()
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
      mode_labels = {
        n = 'NO',
        i = 'IN',
        v = 'VI',
        [''] = 'VB',
        V = 'VL',
        c = 'CO',
        no = 'red',
        s = 'SE',
        S = 'SL',
        [''] = 'SB',
        ic = 'yellow',
        R = 'RE',
        Rv = 'red',
        cv = 'red',
        ce = 'red',
        r = 'red',
        rm = 'red',
        ['r?'] = 'cyan',
        ['!'] = 'red',
        t = 'TE',
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

    local filepath = vim.fn.expand('%t')

    if filepath == '' then
      filepath = '[No Name]'
    end

    return filepath
  end,
}

M.file_flags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' [+]',
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

M.ruler = {
  provider = '%5(%3l:%-2c%)',
}

return M
