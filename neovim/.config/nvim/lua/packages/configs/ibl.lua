require('ibl').setup({
  enabled = vim.g.settings.indent_guides.render,
  indent = {
    char = vim.g.settings.indent_guides.character,
    tab_char = vim.g.settings.indent_guides.character,
  },
  current_indent = { enabled = true, show_start = false, show_end = false },
  scope = { enabled = false },
})
