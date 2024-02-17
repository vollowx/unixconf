require('catppuccin').setup({
  integrations = {
    treesitter = true,
    native_lsp = { enabled = true },

    alpha = false,
    dap = false,
    dap_ui = false,
    dashboard = false,
    fidget = false,
    flash = false,
    illuminate = { enabled = false },
    mini = { enabled = false },
    neogit = false,
    nvimtree = false,
    rainbow_delimiters = false,
    ufo = false,

    beacon = true,
    cmp = true,
    gitsigns = true,
    headlines = true,
    indent_blankline = { enabled = true, scope_color = 'surface1' },
    markdown = true,
    noice = true,
    semantic_tokens = true,
    telescope = { enabled = true, style = 'nvchad' },
  },
  highlight_overrides = {
    all = function(cp)
      return {
        VertSplit = { fg = cp.surface0 },
        WinSeparator = { fg = cp.surface0 },
        NormalFloat = { bg = cp.mantle },
        FloatBorder = { bg = cp.mantle, fg = cp.mantle },
        FloatTitle = { bg = cp.mantle, fg = cp.mantle },

        LspInfoBorder = { link = 'FloatBorder' },
        GitSignsChange = { fg = cp.peach },
        NoiceCmdlineIcon = { style = {} },

        TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
        TelescopePreviewNormal = { bg = cp.crust },
        TelescopePreviewTitle = { fg = cp.crust, bg = cp.crust },
        TelescopePromptBorder = { bg = cp.surface0, fg = cp.surface0 },
        TelescopePromptCounter = { fg = cp.mauve, style = { 'bold' } },
        TelescopePromptNormal = { bg = cp.surface0 },
        TelescopePromptPrefix = { bg = cp.surface0 },
        TelescopePromptTitle = { fg = cp.surface0, bg = cp.surface0 },
        TelescopeResultsBorder = { bg = cp.mantle, fg = cp.mantle },
        TelescopeResultsNormal = { bg = cp.mantle },
        TelescopeResultsTitle = { fg = cp.mantle, bg = cp.mantle },
        TelescopeSelection = { bg = cp.surface0 },

        Stl1 = { fg = cp.mauve, bg = cp.surface1, style = { 'bold' } },
        Stl2 = { fg = cp.surface1, bg = cp.surface0 },
        Stl3 = { fg = cp.surface0, bg = cp.crust },
      }
    end,
  },
})
