local cmd = vim.api.nvim_create_user_command

cmd('Q', 'q', {})
cmd('W', 'w', {})
cmd('Qa', 'qa', {})
cmd('Wq', 'wq', {})

cmd('LspFormat', function()
  vim.lsp.buf.format()
end, {})
