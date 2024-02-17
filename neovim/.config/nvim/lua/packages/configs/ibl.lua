require('ibl').setup({
  enabled = settings.indent_guides.render,
  indent = {
    char = settings.indent_guides.character,
    tab_char = settings.indent_guides.character,
  },
  current_indent = { enabled = true, show_start = false, show_end = false },
  scope = { enabled = false },
})
