-- stylua: ignore start
local clang_format = require('efmls-configs.formatters.clang_format')
local clang_tidy   = require('efmls-configs.linters.clang_tidy')
local eslint       = require('efmls-configs.linters.eslint')
local fish         = require('efmls-configs.linters.fish')
local fish_indent  = require('efmls-configs.formatters.fish_indent')
local prettier     = require('efmls-configs.formatters.prettier')
local shfmt        = require('efmls-configs.formatters.shfmt')
local stylua       = require('efmls-configs.formatters.stylua')

local languages = {
  astro           = { eslint, prettier },
  c               = { clang_tidy, clang_format },
  cpp             = { clang_tidy, clang_format },
  fish            = { fish, fish_indent },
  html            = { prettier },
  javascript      = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  lua             = { stylua },
  sh              = { shfmt },
  typescript      = { eslint, prettier },
  typescriptreact = { eslint, prettier },
}
-- stylua: ignore end

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
