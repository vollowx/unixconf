vim.loader.enable()

vim.g.has_ui = #vim.api.nvim_list_uis() > 0
vim.g.has_gui = vim.g.has_ui and (vim.env.DISPLAY ~= nil or vim.env.WAYLAND_DISPLAY ~= nil)

require('core.settings')
require('core.options')
require('core.keymaps')
require('core.commands')
require('core.autocmds')
require('core.packages')
