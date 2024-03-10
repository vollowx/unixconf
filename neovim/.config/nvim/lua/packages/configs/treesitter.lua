require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  incremental_selection = { enable = false },
  indent = { enable = true },

  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
  matchup = { enable = true },
})
