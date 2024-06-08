return {
  { 'nvim-lua/plenary.nvim' },

  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = 'vollowx/nvim-web-devicons',
    event = 'VeryLazy',
    config = loader_of('devicons-auto-colors'),
  },
}
