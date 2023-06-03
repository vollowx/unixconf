return function()
	local icons = {
		diagnostics = require("modules.utils.icons").get("diagnostics", true),
		misc = require("modules.utils.icons").get("misc", true),
		git = require("modules.utils.icons").get("git", true),
		ui = require("modules.utils.icons").get("ui", true),
	}

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local function lsp_status()
		if rawget(vim, "lsp") then
			for _, client in ipairs(vim.lsp.get_active_clients()) do
				if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
					return (vim.o.columns > 100 and "%#St_LspStatus#" .. "󱕷 LSP ~ " .. client.name) or "󱕷 LSP"
				end
			end
		end
		return "󱕷 No LSP"
	end

	local function get_cwd()
		local cwd = vim.fn.getcwd()
		local is_windows = require("core.global").is_windows
		if not is_windows then
			local home = require("core.global").home
			if cwd:find(home, 1, true) == 1 then
				cwd = "~" .. cwd:sub(#home + 1)
			end
		end
		return icons.ui.RootFolderOpened .. cwd
	end

	local mini_sections = {
		lualine_a = { "filetype" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
	local outline = {
		sections = mini_sections,
		filetypes = { "lspsagaoutline" },
	}
	local diffview = {
		sections = mini_sections,
		filetypes = { "DiffviewFiles" },
	}

	local function python_venv()
		local function env_cleanup(venv)
			if string.find(venv, "/") then
				local final_venv = venv
				for w in venv:gmatch("([^/]+)") do
					final_venv = w
				end
				venv = final_venv
			end
			return venv
		end

		if vim.bo.filetype == "python" then
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
		end
		return ""
	end

	local colors = require("modules.utils").get_palette()
	local custom_catppuccin = require("lualine.themes.catppuccin")
	custom_catppuccin.normal.c.fg = colors.overlay0

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = custom_catppuccin,
			disabled_filetypes = {},
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(name)
						return icons.misc.ManUp .. name
					end,
				},
			},
			lualine_b = {
				{ "filetype", colored = false, icon_only = true, padding = { left = 1 } },
				{ "filename" },
			},
			lualine_c = {
				{ "branch", icon = string.sub(icons.git.Branch, 1, 4), padding = { left = 1 } },
				{
					"diff",
					colored = false,
					symbols = {
						added = icons.git.Add,
						modified = icons.git.Mod,
						removed = icons.git.Remove,
					},
					source = diff_source,
				},
				-- This can make things after this in section c centered
				function()
					return "%="
				end,
				{
					"searchcount",
					maxcount = 999,
					timeout = 500,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warning,
						info = icons.diagnostics.Information,
						hint = icons.diagnostics.Hint,
					},
				},
				lsp_status,
			},
			lualine_y = {
				get_cwd,
				python_venv,
			},
			lualine_z = {
				{ "location" },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			"quickfix",
			"nvim-tree",
			"nvim-dap-ui",
			"toggleterm",
			"fugitive",
			outline,
			diffview,
		},
	})
end
