require('diagflow').setup({
  enable = function()
    return vim.bo.filetype ~= 'lazy'
  end,
})
