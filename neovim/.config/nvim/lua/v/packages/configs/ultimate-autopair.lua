require('ultimate-autopair').setup({
  extensions = {
    -- Improve performance when typing fast, see
    -- https://github.com/altermo/ultimate-autopair.nvim/issues/74
    tsnode = false,
    utf8 = false,
    filetype = { tree = false },
  },
  {
    '<',
    '>',
    disable_start = true,
    disable_end = true,
  },
  {
    '/*',
    '*/',
    ft = { 'c', 'cpp', 'cuda' },
    newline = true,
    space = true,
  },
  {
    '*',
    '*',
    ft = { 'markdown' },
    disable_start = true,
    disable_end = true,
  },
})
