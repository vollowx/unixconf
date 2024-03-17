require('noice').setup({
  health = { checker = false },
  cmdline = {
    format = {
      cmdline = { icon = icons.ui.Cmd },
      search_down = { icon = icons.ui.Magnify },
      search_up = { icon = icons.ui.Magnify },
      filter = { icon = '$' },
      lua = { icon = icons.ft.Lua },
      help = { icon = icons.ui.Help },
      input = {},
    },
    opts = {
      win_options = {
        winhighlight = {
          Normal = 'NormalFloat',
          FloatBorder = 'FloatBorder',
        },
      },
    },
  },
  lsp = {
    progress = { enabled = true },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    signature = { enabled = false },
  },
  views = {
    cmdline_popup = {
      position = { row = '30%', col = '50%' },
      size = { width = '30%' },
    },
  },
  presets = { long_message_to_split = true, lsp_doc_border = true },
  -- popupmenu = { backend = 'cmp' }, -- TODO: Configure cmp-cmdline
  format = {},
})
