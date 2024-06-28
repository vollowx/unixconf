local components = require('packages.configs.heirline.components')
local conds = require('heirline.conditions')

return {
  { -- left
    components.mode(),
    components.padding(1),
    components.filepath,
    components.file_flags,
    { condition = conds.is_active, components.padding(1), components.git },
  },
  components.spacer,
  { -- center
  },
  components.spacer,
  { -- right
    {
      condition = conds.is_active,
      components.lsp,
      components.padding(1),
      components.diag,
      components.padding(1),
    },
    components.pos,
    components.padding(1),
  },

  hl = function()
    return {
      bg = 'bg',
      fg = conds.is_active() and 'fg' or 'fg_nc',
    }
  end,
}
