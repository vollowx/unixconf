return {
  {
    'folke/noice.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'VeryLazy',
    config = loader_of('noice'),
  },

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
    'lukas-reineke/indent-blankline.nvim',
    branch = 'current-indent',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = loader_of('ibl'),
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    config = loader_of('scroll-eof'),
  },
}
