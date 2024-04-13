return {
  {
    'hrsh7th/nvim-cmp',
    config = loader_of('cmp'),
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
    'zbirenbaum/copilot-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        config = loader_of('copilot'),
      },
    },
  },
  config = loader_of('copilot-cmp'),
}
