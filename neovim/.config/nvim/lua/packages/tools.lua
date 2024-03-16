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
    'NvChad/nvim-colorizer.lua',
    enabled = vim.g.has_gui,
    event = { 'BufReadPre', 'BufNewFile' },
    config = loader_of('colorizer'),
  },

  {
    'smoka7/hop.nvim',
    config = loader_of('hop'),
    keys = {
      -- stylua: ignore start
      { 'f', function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end },
      { 'F', function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end },
      { 't', function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, hint_offset = -1 }) end },
      { 'T', function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, hint_offset = -1 }) end },
      -- stylua: ignore end
    },
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
