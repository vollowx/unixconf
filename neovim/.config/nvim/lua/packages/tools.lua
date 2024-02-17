return {
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    config = C('scroll-eof'),
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
    config = C('telescope'),
    keys = {
      { '<Leader>ff', '<Cmd>Telescope find_files<CR>' },
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
    config = C('gitsigns'),
  },

  {
    'NvChad/nvim-colorizer.lua',
    enabled = vim.g.has_gui,
    event = { 'BufReadPre', 'BufNewFile' },
    config = C('colorizer'),
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<Leader>z', '<Cmd>ZenMode<CR>' },
    },
  },
}
