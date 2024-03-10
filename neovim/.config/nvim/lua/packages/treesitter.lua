return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'VeryLazy' },
    config = load_pkg('treesitter', true),
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
  },

  {
    'Wansmer/treesj',
    keys = {
      {
        'J',
        function()
          require('treesj').toggle()
        end,
      },
    },
  },

  {
    'Eandrju/cellular-automaton.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = 'CellularAutomaton',
  },
}
