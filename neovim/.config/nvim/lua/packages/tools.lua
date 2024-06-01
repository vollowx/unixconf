return {
  {
    'wakatime/vim-wakatime',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'tpope/vim-sleuth',
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
    'NvChad/nvim-colorizer.lua',
    enabled = vim.g.has_gui,
    event = { 'BufReadPre', 'BufNewFile' },
    config = loader_of('colorizer'),
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
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    event = 'LspAttach',
    config = loader_of('telescope'),
    keys = {
      { '<Leader>f', '<Nop>', desc = 'Find...' },
      {
        '<Leader>ff',
        '<Cmd>Telescope find_files hidden=true<CR>',
        desc = 'Find file',
      },
      {
        '<Leader>fo',
        '<Cmd>Telescope oldfiles<CR>',
        desc = 'Find recent file',
      },
      { '<Leader>fw', '<Cmd>Telescope live_grep<CR>', desc = 'Find word' },
      {
        '<Leader>fb',
        '<Cmd>Telescope buffers<CR>',
        desc = 'Find buffer',
      },
      {
        '<Leader>fc',
        '<Cmd>Telescope colorscheme<CR>',
        desc = 'Find colorschemes',
      },
      {
        '<Leader>fh',
        '<Cmd>Telescope highlights<CR>',
        desc = 'Find highlight',
      },

      {
        'gd',
        '<Cmd>Telescope lsp_definitions<CR>',
        desc = 'Go to definitions',
      },
      {
        'gD',
        '<Cmd>Telescope lsp_type_definitions<CR>',
        desc = 'Go to type definitions',
      },
      {
        'gi',
        '<Cmd>Telescope lsp_implementations<CR>',
        desc = 'Go to implementations',
      },

      {
        'grr',
        '<Cmd>Telescope lsp_references<CR>',
        desc = 'Go to references',
      },
    },
  },
}
