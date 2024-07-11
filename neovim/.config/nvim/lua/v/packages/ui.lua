return {
  {
    'DanilaMihailov/beacon.nvim',
    event = { 'CursorMoved', 'WinEnter', 'FocusGained' },
    config = load_pkg('beacon'),
  },

  {
    'brenoprata10/nvim-highlight-colors',
    enabled = vim.g.has_gui,
    event = 'VeryLazy',
    config = load_pkg('highlight-colors'),
  },

  {
    'echasnovski/mini.clue',
    event = { 'CursorHold', 'CursorHoldI' },
    config = load_pkg('mini-clue'),
  },

  {
    'nacro90/numb.nvim',
    event = 'CmdlineEnter',
    config = load_pkg('numb'),
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
    config = load_pkg('local-highlight'),
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    config = load_pkg('scroll-eof'),
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = load_pkg('ibl'),
  },
}
