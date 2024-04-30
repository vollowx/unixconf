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
    'b0o/incline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = loader_of('incline'),
  },

  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    config = loader_of('fidget'),
  },

  {
    'nvim-zh/colorful-winsep.nvim',
    event = 'WinNew',
    config = loader_of('colorful-winsep'),
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'current-indent',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = loader_of('ibl'),
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
