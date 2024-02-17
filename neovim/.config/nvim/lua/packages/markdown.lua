return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = vim.g.has_gui,
    ft = 'markdown',
    build = 'cd app && npm install && cd - && git restore .',
    config = C('markdown-preview'),
  },

  {
    'dhruvasagar/vim-table-mode',
    cmd = 'TableModToggle',
    ft = 'markdown',
    config = C('table-mode'),
  },

  {
    'lukas-reineke/headlines.nvim',
    ft = { 'markdown', 'norg', 'rmd', 'org' },
    config = C('headlines', true),
  },
}
