return {
  {
    'yorickpeterse/nvim-pqf',
    event = 'VeryLazy',
    config = loader_of('pqf'),
  },

  {
    'rainbowhxch/beacon.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = loader_of('beacon'),
  },

  {
    'brenoprata10/nvim-highlight-colors',
    enabled = vim.g.has_gui,
    event = 'VeryLazy',
    config = loader_of('highlight-colors'),
  },

  {
    'rebelot/heirline.nvim',
    event = 'VeryLazy',
    config = loader_of('heirline'),
  },

  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    config = loader_of('fidget'),
  },

  {
    'echasnovski/mini.clue',
    event = { 'CursorHold', 'CursorHoldI' },
    config = loader_of('mini-clue'),
  },

  {
    'nacro90/numb.nvim',
    event = 'CmdlineEnter',
    config = loader_of('numb'),
  },

  {
    'winston0410/range-highlight.nvim',
    dependencies = 'winston0410/cmd-parser.nvim',
    event = 'CmdlineEnter',
    opts = {
      highlight = 'Visual',
    },
  },

  {
    'tzachar/local-highlight.nvim',
    event = 'VeryLazy',
    config = loader_of('local-highlight'),
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    config = loader_of('scroll-eof'),
  },

  {
    'mcauley-penney/visual-whitespace.nvim',
    event = 'ModeChanged',
    config = loader_of('visual-whitespace'),
  },
}
