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
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      'dist/',
      'build/',
      'target/',
      '**/*.png',
      '**/*.jpg',
      '**/*.jpeg',
      '**/*.webp',
      '**/*.mp4',
      '**/*.gif',
      '**/*.mp3',
      '**/*.woff2',
      '**/*.woff',
      '**/*.otf',
      '**/*.ttf',
    },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,

    border = {},
    borderchars = { '' },

    mappings = { i = { ['<Esc>'] = require('telescope.actions').close } },
    prompt_prefix = ' ' .. icons.ui.Magnify,
    selection_caret = ' ',
    entry_prefix = ' ',
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
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    preview = { msg_bg_fillchar = ' ' },
  },
  pickers = {
    colorscheme = { enable_preview = true },
    live_grep = { additional_args = { '--hidden' } },
    lsp_references = { include_current_line = true, jump_type = 'never' },
    lsp_definitions = { jump_type = 'never' },
    lsp_type_definitions = { jump_type = 'never' },
    spell_suggest = layout_dropdown,
  },
})
