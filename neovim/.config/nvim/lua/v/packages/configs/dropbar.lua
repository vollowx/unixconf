local utils = require('v.utils')

require('dropbar').setup({
  icons = {
    kinds = { symbols = icons.kinds },
    ui = {
      bar = {
        separator = icons.ui.AngleRight,
        extends = vim.opt.listchars.extends,
      },
      menu = {
        separator = ' ',
        indicator = icons.ui.AngleRight,
      },
    },
  },
})

---Set WinBar & WinBarNC background to Normal background
---@return nil
local function clear_winbar_bg()
  ---@param name string
  ---@return nil
  local function _clear_bg(name)
    local hl = utils.hl.get(0, {
      name = name,
      winhl_link = false,
    })
    if hl.bg or hl.ctermbg then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end

  _clear_bg('WinBar')
  _clear_bg('WinBarNC')
end

clear_winbar_bg()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('WinBarHlClearBg', {}),
  callback = clear_winbar_bg,
})
