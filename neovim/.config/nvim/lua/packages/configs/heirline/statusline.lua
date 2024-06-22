local components = require('packages.configs.heirline.components')

vim.opt.laststatus = 3

return {
  { -- left
    components.mode(),
    components.padding(1),
    components.filepath,
    components.file_flags,
  },
  components.spacer,
  { -- center
  },
  components.spacer,
  { -- right
    components.ruler,
    components.padding(1),
  },

  hl = {
    bg = 'bg',
    fg = 'fg',
  },
}
