require('catppuccin').setup({
  term_colors = true,
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    functions = { 'italic' },
    keywords = { 'italic' },
    numbers = { 'bold' },
    types = { 'bold' },
  },
  default_integrations = false,
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
      inlay_hints = { background = false },
    },

    beacon = true,
    cmp = true,
    fidget = true,
    gitsigns = true,
    headlines = true,
    hop = true,
    markdown = true,
    mini = { enabled = true },
    neogit = true,
    semantic_tokens = true,
    telescope = { enabled = true, style = 'nvchad' },
  },
  highlight_overrides = {
    all = function(cp)
      return {
        WinSeparator = { fg = cp.surface1 },
        WinSeparatorFocused = { fg = cp.mauve },
        VisualWhitespace = { bg = cp.surface1, fg = cp.surface2 },
        CmpGhostText = { link = 'Comment' },
        LspInfoBorder = { link = 'FloatBorder' },
        FzfLuaBorder = { link = 'WinSeparator' },
        GitSignsChange = { fg = cp.peach },
        GitSignsCurrentLineBlame = { link = 'Comment' },
      }
    end,
  },
})
