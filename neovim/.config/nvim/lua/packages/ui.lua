return {
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    config = load_pkg('heirline'),
  },

  {
    'rainbowhxch/beacon.nvim',
    event = 'UIEnter',
    config = load_pkg('beacon'),
  },

  {
    'andymass/vim-matchup',
    event = { 'BufReadPre', 'BufNewFile' },
    config = load_pkg('matchup', true),
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'current-indent',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = load_pkg('ibl'),
  },
}
