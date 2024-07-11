return {
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = load_pkg('symbol-usage'),
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspStart' },
    config = load_pkg('lspconfig', true),
    keys = {
      {
        '<Leader>l',
        '<Nop>',
        desc = 'LSP...',
      },
      {
        '<Leader>la',
        '<Cmd>LspStart<CR>',
        desc = 'Start servers',
      },
      {
        '<Leader>li',
        '<Cmd>LspInfo<CR>',
        desc = 'Server information',
      },
      {
        '<Leader>ll',
        '<Cmd>LspLog<CR>',
        desc = 'Open log',
      },
      {
        '<Leader>lr',
        '<Cmd>LspRestart<CR>',
        desc = 'Restart servers',
      },
      {
        '<Leader>ls',
        '<Cmd>LspStop<CR>',
        desc = 'Stop servers',
      },
    },
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
          opts_override_floating_preview.max_width = math.max(80, math.ceil(vim.go.columns * 0.75))
          opts_override_floating_preview.max_height = math.max(20, math.ceil(vim.go.lines * 0.4))
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
        opts = vim.tbl_deep_extend('force', opts, opts_override_floating_preview)
        local floating_bufnr, floating_winnr = _open_floating_preview(contents, syntax, opts)
        vim.wo[floating_winnr].concealcursor = 'nc'
        return floating_bufnr, floating_winnr
      end

      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = vim.trim(icons.ui.AngleLeft),
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.ui.DotLarge,
            [vim.diagnostic.severity.WARN] = icons.ui.DotLarge,
            [vim.diagnostic.severity.INFO] = icons.ui.DotLarge,
            [vim.diagnostic.severity.HINT] = icons.ui.DotLarge,
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
