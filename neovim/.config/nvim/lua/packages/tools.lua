return {
  {
    'wakatime/vim-wakatime',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'NMAC427/guess-indent.nvim',
    cmd = { 'GuessIndent' },
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'echasnovski/mini.bracketed',
    config = load_pkg('mini-bracketed'),
    keys = { '[', ']' },
  },

  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<Leader>x',
        function()
          require('mini.bufremove').delete()
        end,
        desc = 'Close current buffer',
      },
    },
  },

  {
    'echasnovski/mini.jump',
    config = load_pkg('mini-jump'),
    keys = {
      { 'f', mode = { 'n', 'x' } },
      { 'F', mode = { 'n', 'x' } },
      { 't', mode = { 'n', 'x' } },
      { 'T', mode = { 'n', 'x' } },
      { ';', mode = { 'n', 'x' } },
    },
  },

  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    keys = {
      { '<Leader>gg', '<Cmd>G<CR>', desc = 'Open Fugitive panel' },
      { '<Leader>gaa', '<Cmd>G add --all<CR>', desc = 'Add all' },
      { '<Leader>gc', '<Cmd>G commit<CR>', desc = 'Commit' },
      { '<Leader>gp', '<Cmd>G pull<CR>', desc = 'Pull from remote' },
      { '<Leader>gP', '<Cmd>G push<CR>', desc = 'Push to remote' },
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    cmd = { 'Oil' },
    config = load_pkg('oil'),
    keys = {
      { '-', '<Cmd>Oil<CR>', desc = 'Open parent directory' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = load_pkg('gitsigns'),
    keys = {
      { '<Leader>g', '<Nop>', desc = 'Git...' },
      {
        '<Leader>gd',
        '<Cmd>Gitsigns diffthis<CR>',
        desc = 'Diff',
      },
      {
        '<Leader>gl',
        '<Cmd>Gitsigns blame_line<CR>',
        desc = 'Line blame',
      },
    },
  },

  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    config = load_pkg('conform'),
    keys = {
      {
        'gq',
        function()
          require('conform').format({ async = true, lsp_fallback = false })
        end,
        desc = 'Format',
      },
    },
    init = function()
      vim.opt.formatexpr = 'v:lua.require"conform".formatexpr()'
    end,
  },

  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
  },

  {
    'ibhagwan/fzf-lua',
    cmd = 'Telescope',
    event = 'LspAttach',
    config = load_pkg('fzf'),
    keys = {
      { '<Leader>f', '<Nop>', desc = 'Find...' },
      {
        '<Leader>ff',
        '<Cmd>FzfLua files<CR>',
        desc = 'Find file',
      },
      {
        '<Leader>fo',
        '<Cmd>FzfLua oldfiles<CR>',
        desc = 'Find old file',
      },
      { '<Leader>fw', '<Cmd>FzfLua live_grep<CR>', desc = 'Find word' },
      {
        '<Leader>fb',
        '<Cmd>FzfLua buffers<CR>',
        desc = 'Find buffer',
      },
      {
        '<Leader>fc',
        '<Cmd>FzfLua colorschemes<CR>',
        desc = 'Find colorschemes hidden=true',
      },

      {
        'gd',
        '<Cmd>FzfLua lsp_definitions<CR>',
        desc = 'Go to definitions',
      },
      {
        'gD',
        '<Cmd>FzfLua lsp_type_definitions<CR>',
        desc = 'Go to type definitions',
      },
      {
        'gi',
        '<Cmd>FzfLua lsp_implementations<CR>',
        desc = 'Go to implementations',
      },

      {
        'grr',
        '<Cmd>FzfLua lsp_references<CR>',
        desc = 'Go to references',
      },
    },
  },
}
