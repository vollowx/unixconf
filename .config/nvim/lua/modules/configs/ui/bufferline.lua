return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		diagnostics = require("modules.utils.icons").get("diagnostics", true),
	}

	local opts = {
		options = {
			number = nil,
			modified_icon = icons.ui.Modified,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 20,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			enforce_regular_tabs = true,
			persist_buffer_sort = true,
			always_show_bufferline = true,
			separator_style = "none",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diagnostics_dict, _)
				local str = ""
				for is, num in pairs(diagnostics_dict) do
					local sym = is == "error" and icons.diagnostics.Error
						or (
							is == "warning" and icons.diagnostics.Warning
							or (is == "info" and icons.diagnostics.Information or icons.diagnostics.Hint)
						)
					str = str .. " " .. sym .. num
				end
				return str
			end,
			indicator = "none",
			offsets = {
				{
					filetype = "NvimTree",
					text = "",
					text_align = "center",
					padding = 0,
				},
				{
					filetype = "lspsagaoutline",
					text = "",
					text_align = "center",
					padding = 0,
				},
			},
		},
		-- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
		-- Note: If you use catppuccin then modify the colors below!
		highlights = {},
	}

	if vim.g.colors_name:find("catppuccin") then
		local cp = require("modules.utils").get_palette() -- Get the palette.

		local catppuccin_hl_overwrite = {
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "bold" },
				custom = {
					all = {
						buffer_visible = { bg = cp.base },
						fill = { bg = cp.mantle },
					},
				},
			}),
		}

		opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
	end

	require("bufferline").setup(opts)
end
