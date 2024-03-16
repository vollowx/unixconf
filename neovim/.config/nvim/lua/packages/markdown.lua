return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = vim.g.has_gui,
    ft = 'markdown',
    build = 'cd app && npm install && cd - && git restore .',
    config = loader_of('markdown-preview'),
  },

  {
    'dhruvasagar/vim-table-mode',
    cmd = 'TableModToggle',
    ft = 'markdown',
    config = loader_of('table-mode'),
  },

  {
    'lukas-reineke/headlines.nvim',
    ft = { 'markdown', 'norg', 'rmd', 'org' },
    config = loader_of('headlines', true),
  },
}
