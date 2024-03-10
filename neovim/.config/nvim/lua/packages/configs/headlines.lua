local opts = {
  headline_highlights = {},
  codeblock_highlight = 'CursorLine',
  fat_headlines = false,
}

require('headlines').setup({
  markdown = opts,
  norg = opts,
  org = opts,
  rmd = opts,
})
