return {
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = loader_of('symbol-usage'),
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspStart' },
    config = loader_of('lspconfig', true),
    init = function()
      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          prefix = vim.trim(icons.ui.AngleLeft),
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.DiagnosticSignError,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.DiagnosticSignWarn,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.DiagnosticSignInfo,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.DiagnosticSignHint,
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          },
        },
      })
    end,
  },

  { 'b0o/schemastore.nvim' },
}
