require('dropbar').setup({
  icons = {
    kinds = { symbols = icons.kinds },
    ui = {
      bar = { seperator = icons.ui.AngleRight, extends = icons.ui.Ellipsis },
      menu = { seperator = ' ', indicator = icons.ui.AngleRight },
    },
  },
})
