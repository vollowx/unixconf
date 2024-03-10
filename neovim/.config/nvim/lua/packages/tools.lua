return {
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'echasnovski/mini.bracketed',
    config = load_pkg('mini-bracketed'),
    keys = { '[', ']' },
  },

  {
    'smoka7/hop.nvim',
    config = load_pkg('hop'),
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
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    event = 'LspAttach',
    config = load_pkg('telescope'),
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

  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'telescope-ui-select.nvim' } })
        return vim.ui.select(...)
      end
    end,
    config = function()
      require('telescope').load_extension('ui-select')
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = load_pkg('gitsigns'),
  },

  {
    'NvChad/nvim-colorizer.lua',
    enabled = vim.g.has_gui,
    event = { 'BufReadPre', 'BufNewFile' },
    config = load_pkg('colorizer'),
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<Leader>z', '<Cmd>ZenMode<CR>' },
    },
  },
}
