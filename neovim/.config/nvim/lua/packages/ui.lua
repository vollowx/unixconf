return {
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    config = loader_of('heirline'),
  },

  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    config = loader_of('dropbar'),
    keys = {
      {
        '<Leader>;',
        function()
          require('dropbar.api').pick()
        end,
      },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dropbar.nvim' } })
        vim.ui.select = require('dropbar.utils.menu').select
        return vim.ui.select(...)
      end
    end,
  },

  {
    'rainbowhxch/beacon.nvim',
    event = 'UIEnter',
    config = loader_of('beacon'),
  },

  {
    'andymass/vim-matchup',
    event = { 'BufReadPre', 'BufNewFile' },
    config = loader_of('matchup', true),
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
