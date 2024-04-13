return {
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
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<Leader>z', '<Cmd>ZenMode<CR>' },
    },
  },

  {
    'https://github.com/nacro90/numb.nvim',
    event = 'CmdlineEnter',
    config = loader_of('numb'),
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
      { '<Leader>ff', '<Cmd>Telescope find_files hidden=true<CR>' },
      { '<Leader>fo', '<Cmd>Telescope oldfiles<CR>' },
      { '<Leader>fw', '<Cmd>Telescope live_grep<CR>' },
      { '<Leader>fb', '<Cmd>Telescope buffers<CR>' },
      { '<Leader>fc', '<Cmd>Telescope colorscheme<CR>' },
      { '<Leader>fh', '<Cmd>Telescope highlights<CR>' },

      { 'gd', '<Cmd>Telescope lsp_definitions<CR>' },
      { 'gD', '<Cmd>Telescope lsp_type_definitions<CR>' },
      { 'gi', '<Cmd>Telescope lsp_implementations<CR>' },
      { 'gr', '<Cmd>Telescope lsp_references<CR>' },
    },
  },
}
