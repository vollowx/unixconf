require('gitsigns').setup({
  preview_config = {
    border = vim.g.settings.ui.border_preview,
    style = 'minimal',
  },
  signs = {
    add = { text = vim.trim(vim.g.icons.ui.GitSignAdd) },
    untracked = { text = vim.trim(vim.g.icons.ui.GitSignUntracked) },
    change = { text = vim.trim(vim.g.icons.ui.GitSignChange) },
    delete = { text = vim.trim(vim.g.icons.ui.GitSignDelete) },
    topdelete = { text = vim.trim(vim.g.icons.ui.GitSignTopdelete) },
    changedelete = { text = vim.trim(vim.g.icons.ui.GitSignChangedelete) },
  },
  current_line_blame = vim.g.settings.git.display_blame,
  attach_to_untracked = true,
})
