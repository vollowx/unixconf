local telescope = require('telescope')

local layout_dropdown = {
  previewer = false,
  layout_config = {
    width = 0.6,
    height = 0.65,
  },
}

telescope.setup({
  defaults = {
    mappings = { i = { ['<Esc>'] = require('telescope.actions').close } },
    prompt_prefix = icons.ui.Magnify,
    selection_caret = icons.ui.AngleRight,
    layout_config = {
      width = 0.8,
      height = 0.8,
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      vertical = {
        prompt_position = 'top',
        mirror = true,
      },
    },
    results_title = false,
    sorting_strategy = 'ascending',
  },
  pickers = {
    colorscheme = { enable_preview = true },
    live_grep = { additional_args = { '--hidden' } },
    lsp_references = { include_current_line = true, jump_type = 'never' },
    lsp_definitions = { jump_type = 'never' },
    lsp_type_definitions = { jump_type = 'never' },
    spell_suggest = layout_dropdown,
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(layout_dropdown),
    },
  },
})
