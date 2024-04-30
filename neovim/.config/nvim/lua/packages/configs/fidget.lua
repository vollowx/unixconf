require('fidget').setup({
  progress = {
    display = {
      done_icon = icons.ui.Ok,
    },
  },
})

vim.notify = require('fidget.notification').notify
