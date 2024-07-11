return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = load_pkg('treesitter', true),
    dependencies = {
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
    cmd = 'CellularAutomaton',
  },
}
