require('conform').setup({
  formatters_by_ft = {
    -- stylua: ignore start
    ['_']           = { 'trim_newlines', 'trim_whitespace' },
    astro           = { 'prettier' },
    bash            = { 'shfmt' },
    c               = { 'clang-format' },
    cpp             = { 'clang-format' },
    css             = { 'prettier' },
    fish            = { 'fish_indent' },
    html            = { 'prettier' },
    json            = { 'prettier' },
    lua             = { 'stylua' },
    javascript      = { 'prettier' },
    javascriptreact = { 'prettier' },
    rust            = { 'rustfmt' },
    sh              = { 'shfmt' },
    typescript      = { 'prettier' },
    typescriptreact = { 'prettier' },
    -- stylua: ignore end
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = false,
  },
})
