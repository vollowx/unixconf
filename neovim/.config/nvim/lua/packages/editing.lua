return {
  {
    'andymass/vim-matchup',
    event = { 'BufReadPre', 'BufNewFile' },
    config = C('matchup'),
  },

  {
    'romainl/vim-cool',
    keys = { '/', '?', 'n', 'N' },
  },

  {
    'chrisgrieser/nvim-spider',
    keys = {
      {
        'w',
        function()
          require('spider').motion('w')
        end,
        mode = { 'n', 'o', 'x' },
      },
      {
        'e',
        function()
          require('spider').motion('e')
        end,
        mode = { 'n', 'o', 'x' },
      },
      {
        'b',
        function()
          require('spider').motion('b')
        end,
        mode = { 'n', 'o', 'x' },
      },
    },
  },

  {
    'monaqa/dial.nvim',
    config = C('dial'),
    keys = {
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'normal')
        end,
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'normal')
        end,
      },
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gnormal')
        end,
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gnormal')
        end,
      },
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'visual')
        end,
        mode = { 'v' },
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'visual')
        end,
        mode = { 'v' },
      },
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gvisual')
        end,
        mode = { 'v' },
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gvisual')
        end,
        mode = { 'v' },
      },
    },
  },

  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = C('ultimate-autopair'),
  },

  {
    'numToStr/Comment.nvim',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
      },
    },
    config = C('comment'),
    keys = {
      { 'gc', mode = { 'n', 'x' } },
      { 'gb', mode = { 'n', 'x' } },
    },
  },

  {
    'junegunn/vim-easy-align',
    cmd = { 'EasyAlign', 'LiveEasyAlign' },
    config = C('easy-align'),
    keys = {
      { '<Leader>l', '<Plug>(LiveEasyAlign)', mode = { 'n', 'x' } },
    },
  },
}
