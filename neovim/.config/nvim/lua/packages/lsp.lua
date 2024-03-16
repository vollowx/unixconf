return {
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    config = loader_of('diagflow'),
  },

  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = loader_of('symbol-usage'),
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspStart' },
    config = loader_of('lspconfig', true),
    init = function()
      -- Configure hovering window style
      local opts_override_floating_preview = {
        border = settings.ui.border_preview,
        max_width = math.max(80, math.ceil(vim.go.columns * 0.75)),
        max_height = math.max(20, math.ceil(vim.go.lines * 0.4)),
        close_events = {
          'CursorMoved',
          'CursorMovedI',
          'WinScrolled',
        },
      }
      vim.api.nvim_create_autocmd('VimResized', {
        desc = 'Update LSP floating window maximum size on VimResized.',
        group = vim.api.nvim_create_augroup('LspUpdateFloatingWinMaxSize', {}),
        callback = function()
          opts_override_floating_preview.max_width =
            math.max(80, math.ceil(vim.go.columns * 0.75))
          opts_override_floating_preview.max_height =
            math.max(20, math.ceil(vim.go.lines * 0.4))
        end,
      })
      -- Hijack LSP floating window function to use custom options
      local _open_floating_preview = vim.lsp.util.open_floating_preview
      ---@param contents table of lines to show in window
      ---@param syntax string of syntax to set for opened buffer
      ---@param opts table with optional fields (additional keys are passed on to |nvim_open_win()|)
      ---@returns bufnr,winnr buffer and window number of the newly created floating preview window
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts)
        opts =
          vim.tbl_deep_extend('force', opts, opts_override_floating_preview)
        local floating_bufnr, floating_winnr =
          _open_floating_preview(contents, syntax, opts)
        vim.wo[floating_winnr].concealcursor = 'nc'
        return floating_bufnr, floating_winnr
      end

      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
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
