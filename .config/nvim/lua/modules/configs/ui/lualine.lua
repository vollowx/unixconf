return function()
	local icons = {
		diagnostics = require("modules.utils.icons").get("diagnostics", true),
		git = require("modules.utils.icons").get("git", true),
		ui = require("modules.utils.icons").get("ui", true),
	}
	local iconsNoSpace = { git = require("modules.utils.icons").get("git", false) }

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

	local colors = require("modules.utils").get_palette()
	local custom_catppuccin = {
		normal = {
			a = { fg = colors.green, bg = colors.surface0, gui = "bold" },
			b = { fg = colors.text, bg = colors.mantle },
			c = { fg = colors.text, bg = colors.mantle },
		},
		command = { a = { fg = colors.yellow, bg = colors.surface0, gui = "bold" } },
		insert = { a = { fg = colors.blue, bg = colors.surface0, gui = "bold" } },
		visual = { a = { fg = colors.mauve, bg = colors.surface0, gui = "bold" } },
		terminal = { a = { fg = colors.teal, bg = colors.surface0, gui = "bold" } },
		replace = { a = { fg = colors.red, bg = colors.surface0, gui = "bold" } },
		inactive = {
			a = { fg = colors.subtext0, bg = colors.mantle, gui = "bold" },
			b = { fg = colors.subtext0, bg = colors.mantle },
			c = { fg = colors.subtext0, bg = colors.mantle },
		},
	}

	local conditions = {
		hide_in_width = function()
			return vim.o.columns > 100
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local components = {
		center = {
			function()
				return "%="
			end,
		},
		separator = {
			function()
				return "│"
			end,
			padding = {},
			color = "LualineSeparator",
		},

		filetype = { "filetype", icon_only = true },
		filename = { "filename", padding = { right = 1 } },

		branch = {
			"b:gitsigns_head",
			icon = iconsNoSpace.git.Branch,
			color = "LualineBranch",
		},
		diff = {
			"diff",
			symbols = {
				added = icons.git.Add,
				modified = icons.git.Mod,
				removed = icons.git.Remove,
			},
			source = diff_source,
			colored = false,
			color = "LualineDiff",
			padding = { right = 1 },
		},

		diagnostics = {
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
		lsp = {
			function()
				if rawget(vim, "lsp") then
					local names = {}
					local lsp_exist = false
					for _, client in ipairs(vim.lsp.get_active_clients()) do
						if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
							table.insert(names, client.name)
							lsp_exist = true
						end
					end
					return lsp_exist and "󱜙 [" .. table.concat(names, ", ") .. "]" or "󱚧"
				end
				return "󱚧"
			end,
			color = "LualineLSP",
			cond = conditions.hide_in_width,
		},

		encoding = {
			"o:encoding",
			fmt = string.upper,
			padding = { left = 1 },
			cond = conditions.hide_in_width,
		},
		fileformat = {
			"fileformat",
			symbols = {
				unix = "LF",
				dos = "CRLF",
				mac = "CR",
			},
			padding = { left = 1 },
		},
		spaces = {
			function()
				local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
				return icons.ui.ChevronRight .. shiftwidth
			end,
			padding = 1,
		},

		python_venv = {
			function()
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
			end,
			color = "LualinePyVenv",
			cond = conditions.hide_in_width,
		},
		cwd = {
			function()
				local cwd = vim.fn.getcwd()
				local is_windows = require("core.global").is_windows
				if not is_windows then
					local home = require("core.global").home
					if cwd:find(home, 1, true) == 1 then
						cwd = "~" .. cwd:sub(#home + 1)
					end
				end
				return icons.ui.RootFolderOpened .. cwd
			end,
			color = "LualineCWD",
		},

		location = { "location" },
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = custom_catppuccin,
			disabled_filetypes = { statusline = { "alpha" } },
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				"mode",
			},
			lualine_b = {
				components.filetype,
				components.filename,
				vim.tbl_deep_extend("force", components.separator, { cond = conditions.check_git_workspace }),
			},
			lualine_c = {
				components.branch,
				components.diff,

				components.center,

				components.diagnostics,
				components.lsp,
			},
			lualine_x = {
				components.encoding,
				components.fileformat,
				components.spaces,
			},
			lualine_y = {
				components.separator,
				components.python_venv,
				components.cwd,
			},
			lualine_z = {
				components.location,
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { components.filename },
			lualine_x = { components.location },
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
