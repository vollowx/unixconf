-- Colorschemes other than the default colorscheme looks bad when the terminal
-- does not support truecolor
if not vim.g.has_gui then
  if vim.g.has_ui then
    vim.cmd.colorscheme('default')
  end
  return
end

local utils = {}

utils.fs = {
  ---Read file contents
  ---@param path string
  ---@return string?
  read_file = function(path)
    local file = io.open(path, 'r')
    if not file then
      return nil
    end
    local content = file:read('*a')
    file:close()
    return content or ''
  end,

  ---Write string into file
  ---@param path string
  ---@return boolean success
  write_file = function(path, str)
    local file = io.open(path, 'w')
    if not file then
      return false
    end
    file:write(str)
    file:close()
    return true
  end,
}

utils.json = {
  ---Read json contents as lua table
  ---@param path string
  ---@param opts table? same option table as `vim.json.decode()`
  ---@return table
  read = function(path, opts)
    opts = opts or {}
    local str = utils.fs.read_file(path)
    local ok, tbl = pcall(vim.json.decode, str, opts)
    return ok and tbl or {}
  end,

  ---Write json contents
  ---@param path string
  ---@param tbl table
  ---@return boolean success
  write = function(path, tbl)
    local ok, str = pcall(vim.json.encode, tbl)
    if not ok then
      return false
    end
    return utils.fs.write_file(path, str)
  end,
}

local colors_file = vim.fs.joinpath(vim.fn.stdpath('state') --[[@as string]], 'colors.json')

-- 1. Restore dark/light background and colorscheme from json so that nvim
--    "remembers" the background and colorscheme when it is restarted.
-- 2. Spawn setbg/setcolors on colorscheme change to make other nvim instances
--    and system color consistent with the current nvim instance.

local saved = utils.json.read(colors_file)
saved.colors_name = saved.colors_name or 'catppuccin'

if saved.bg then
  vim.go.bg = saved.bg
end

if saved.colors_name and saved.colors_name ~= vim.g.colors_name then
  vim.cmd.colorscheme({
    args = { saved.colors_name },
    mods = { emsg_silent = true },
  })
end

vim.api.nvim_create_autocmd('Colorscheme', {
  group = vim.api.nvim_create_augroup('Colorscheme', {}),
  desc = 'Spawn setbg/setcolors on colorscheme change.',
  callback = function()
    vim.schedule(function()
      local data = utils.json.read(colors_file)
      if data.colors_name ~= vim.g.colors_name or data.bg ~= vim.go.bg then
        data.colors_name = vim.g.colors_name
        data.bg = vim.go.bg
        if not utils.json.write(colors_file, data) then
          return
        end
      end

      -- pcall(vim.system, { 'setbg', vim.go.bg })
      -- pcall(vim.system, { 'setcolor', vim.g.colors_name })
    end)
  end,
})
