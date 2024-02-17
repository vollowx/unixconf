if vim.env.NVIM_NOTHIRDPARTY then
  return
end

---Load configuration for a specified package
---@param path string
---@param schedule boolean|nil
C = function(path, schedule)
  return schedule
      and function()
        vim.schedule(function()
          require('packages.configs.' .. path)
        end)
      end
    or function()
      require('packages.configs.' .. path)
    end
end

local utils = require('utils')
local conf_path = vim.fn.stdpath('config') --[[@as string]]
local data_path = vim.fn.stdpath('data') --[[@as string]]

---@return boolean
local function bootstrap()
  vim.g.package_path = vim.fs.joinpath(data_path, 'packages')
  vim.g.package_lock = vim.fs.joinpath(conf_path, 'package-lock.json')
  local lazy_path = vim.fs.joinpath(vim.g.package_path, 'lazy.nvim')
  if vim.uv.fs_stat(lazy_path) then
    vim.opt.rtp:prepend(lazy_path)
    return true
  end

  local lock_data = utils.json.read(vim.g.package_lock)
  local commit = lock_data['lazy.nvim'] and lock_data['lazy.nvim'].commit
  local url = 'https://github.com/folke/lazy.nvim.git'
  vim.notify('[packages] installing lazy.nvim...')
  vim.fn.mkdir(vim.g.package_path, 'p')
  if
    not utils.git.execute({
      'clone',
      '--filter=blob:none',
      url,
      lazy_path,
    }, vim.log.levels.INFO).success
  then
    return false
  end

  if commit then
    utils.git.dir_execute(
      lazy_path,
      { 'checkout', commit },
      vim.log.levels.INFO
    )
  end
  vim.notify('[packages] lazy.nvim cloned to ' .. lazy_path)
  vim.opt.rtp:prepend(lazy_path)
  return true
end

---@param module_names string[]
local function setup_lazy(module_names)
  local config = {
    root = vim.g.package_path,
    lockfile = vim.g.package_lock,
    defaults = { lazy = true },
    checker = { enabled = false },
    change_detection = { notify = false },
    ui = {
      border = vim.g.settings.ui.border,
      size = { width = 0.7, height = 0.74 },
      icons = {
        cmd = vim.g.icons.ui.Cmd,
        config = vim.g.icons.ft.Config,
        event = vim.g.icons.kinds.Event,
        ft = vim.g.icons.kinds.File,
        init = vim.g.icons.ft.Config,
        import = vim.g.icons.ui.ArrowLeft,
        keys = vim.g.icons.ui.Keyboard,
        lazy = vim.g.icons.ui.Lazy .. ' ',
        loaded = vim.g.icons.ui.CircleFilled,
        not_loaded = vim.g.icons.ui.CircleOutline,
        plugin = vim.g.icons.kinds.Module,
        runtime = vim.g.icons.kinds.File,
        require = vim.g.icons.ui.Lua,
        source = vim.g.icons.kinds.Method,
        start = vim.g.icons.ui.Play,
        task = vim.g.icons.ui.Ok,
        list = { '' },
      },
    },
    install = { colorscheme = { 'catppuccin' } },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  }
  local modules = {}
  for _, module_name in ipairs(module_names) do
    vim.list_extend(modules, require('packages.' .. module_name))
  end
  require('lazy').setup(modules, config)
end

if not bootstrap() then
  return
end

setup_lazy(vim.g.vscode and vim.g.settings.modules.vscode or vim.g.settings.modules.all)
