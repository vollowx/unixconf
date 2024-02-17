return {
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    config = C('heirline'),
  },

  {
    'rainbowhxch/beacon.nvim',
    event = 'UIEnter',
    config = C('beacon'),
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'current-indent',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = C('ibl'),
  },
}
