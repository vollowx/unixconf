require('lspconfig.ui.windows').default_options.border = settings.ui.border

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Reload LspInfo floating window on VimResized.',
  group = vim.api.nvim_create_augroup('LspInfoResize', {}),
  callback = function()
    if vim.bo.ft == 'lspinfo' then
      vim.api.nvim_win_close(0, true)
      vim.cmd.LspInfo()
    end
  end,
})

local lc = require('lspconfig')

local default_opts = {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  ),
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
}

local server_conf_path = vim.fn.stdpath('config') .. '/lua/v/packages/ls-configs'
local servers = vim.fn.readdir(server_conf_path)

for _, server in ipairs(servers) do
  local server_name = server:gsub('%.lua$', '')
  local server_conf = vim.tbl_deep_extend('force', default_opts, require('v.packages.ls-configs.' .. server_name))
  lc[server_name].setup(server_conf)
end

vim.cmd.LspStart()
