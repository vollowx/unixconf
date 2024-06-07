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
    config = loader_of('mini-bracketed'),
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
    config = loader_of('mini-jump'),
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
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = loader_of('gitsigns'),
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
    config = loader_of('conform'),
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
    config = loader_of('fzf'),
    keys = {
      { '<Leader>f', '<Nop>', desc = 'Find...' },
      {
        '<Leader>ff',
        '<Cmd>FzfLua files hidden=true<CR>',
        desc = 'Find file',
      },
      {
        '<Leader>fo',
        '<Cmd>FzfLua oldfiles<CR>',
        desc = 'Find recent file',
      },
      { '<Leader>fw', '<Cmd>FzfLua live_grep<CR>', desc = 'Find word' },
      {
        '<Leader>fb',
        '<Cmd>FzfLua buffers<CR>',
        desc = 'Find buffer',
      },
      {
        '<Leader>fc',
        '<Cmd>FzfLua colorscheme<CR>',
        desc = 'Find colorschemes hidden=true',
      },
      {
        '<Leader>fh',
        '<Cmd>FzfLua highlights<CR>',
        desc = 'Find highlight',
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
