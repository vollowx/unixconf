return {
  {
    'hrsh7th/nvim-cmp',
    config = load_pkg('cmp'),
  },

  {
    'hrsh7th/cmp-calc',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'hrsh7th/cmp-path',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'hrsh7th/cmp-buffer',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'hrsh7th/cmp-cmdline',
    event = 'CmdlineEnter',
    dependencies = 'hrsh7th/nvim-cmp',
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = load_pkg('copilot'),
  },
}
