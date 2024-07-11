return {
  {
    'rafcamlet/nvim-luapad',
    cmd = { 'Luapad' },
  },

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
    dependencies = 'tpope/vim-rhubarb',
    cmd = { 'Git', 'G' },
    keys = {
      { '<Leader>gg', '<Cmd>G<CR>', desc = 'Open Fugitive panel' },
      { '<Leader>ga', '<Cmd>G add %', desc = 'Add current file' },
      { '<Leader>gA', '<Cmd>G add --all<CR>', desc = 'Add all files' },
      { '<Leader>gc', '<Cmd>G commit<CR>', desc = 'Commit' },
      { '<Leader>gm', '<Cmd>G merge<CR>', desc = 'Merge' },
      { '<Leader>gp', '<Cmd>G pull<CR>', desc = 'Pull from remote' },
      { '<Leader>gP', '<Cmd>G push<CR>', desc = 'Push to remote' },
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-web-devicons' },
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
    'bekaboo/dropbar.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'BufEnter' },
    config = load_pkg('dropbar'),
  },

  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
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
        desc = 'Find colorschemes',
      },

      {
        'gd',
        '<Cmd>FzfLua lsp_definitions<CR>',
        desc = 'Definitions',
      },
      {
        'gD',
        '<Cmd>FzfLua lsp_type_definitions<CR>',
        desc = 'Type definitions',
      },
      {
        'gi',
        '<Cmd>FzfLua lsp_implementations<CR>',
        desc = 'Implementations',
      },
      {
        'ga',
        '<Cmd>FzfLua lsp_references<CR>',
        desc = 'Code action',
      },
      {
        'g.',
        '<Cmd>FzfLua lsp_references<CR>',
        desc = 'References',
      },
      {
        'gs',
        '<Cmd>FzfLua lsp_workspace_symbols<CR>',
        desc = 'Workspace symbols',
      },
      {
        'gS',
        '<Cmd>FzfLua lsp_document_symbols<CR>',
        desc = 'Document symbols',
      },
    },
  },
}
