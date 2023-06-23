local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: nvim-bufdel
	["n|<A-q>"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),

	-- Plugin: clever-f
	["n|;"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-forward)")
	end):with_expr(),
	["n|,"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-back)")
	end):with_expr(),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gbc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: vim-easy-align
	["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

	-- Plugin: hop
	["nv|<leader>w"] = map_cmd("<Cmd>HopWord<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>j"] = map_cmd("<Cmd>HopLine<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>k"] = map_cmd("<Cmd>HopLine<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>c"] = map_cmd("<Cmd>HopChar1<CR>"):with_noremap():with_desc("jump: Goto one char"),
	["nv|<leader>cc"] = map_cmd("<Cmd>HopChar2<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: search-replace
	-- SearchReplaceSingleBuffer
	["n|<leader>rs"] = map_cu("SearchReplaceSingleBufferSelections")
		:with_noremap()
		:with_desc("edit: Show search-repacle menu in current buffer"),
	["n|<leader>ro"] = map_cu("SearchReplaceSingleBufferOpen")
		:with_noremap()
		:with_desc("edit: Search-repacle in current buffer"),
	["n|<leader>rw"] = map_cu("SearchReplaceSingleBufferCWord")
		:with_noremap()
		:with_desc("edit: Search-repacle current buffer CWord"),
	["n|<leader>rW"] = map_cu("SearchReplaceSingleBufferCWORD")
		:with_noremap()
		:with_desc("edit: Search-repacle current buffer CWORD"),
	["n|<leader>re"] = map_cu("SearchReplaceSingleBufferCExpr")
		:with_noremap()
		:with_desc("edit: Search-repacle current buffer CExpr"),
	["n|<leader>rf"] = map_cu("SearchReplaceSingleBufferCFile")
		:with_noremap()
		:with_desc("edit: Search-repacle current buffer CFile"),
	-- SearchReplaceMultiBuffer
	["n|<leader>rbs"] = map_cu("SearchReplaceMultiBufferSelections")
		:with_noremap()
		:with_desc("edit: Show search-repacle menu for multi buffer"),
	["n|<leader>rbo"] = map_cu("SearchReplaceMultiBufferOpen")
		:with_noremap()
		:with_desc("edit: Search-repacle in multi buffers"),
	["n|<leader>rbw"] = map_cu("SearchReplaceMultiBufferCWord")
		:with_noremap()
		:with_desc("edit: Search-repacle multi buffers CWord"),
	["n|<leader>rbW"] = map_cu("SearchReplaceMultiBufferCWORD")
		:with_noremap()
		:with_desc("edit: Search-repacle multi buffers CWORD"),
	["n|<leader>rbe"] = map_cu("SearchReplaceMultiBufferCExpr")
		:with_noremap()
		:with_desc("edit: Search-repacle multi buffers CExpr"),
	["n|<leader>rbf"] = map_cu("SearchReplaceMultiBufferCFile")
		:with_noremap()
		:with_desc("edit: Search-repacle multi buffers CFile"),
	-- Visual Mode
	["v|<C-r>"] = map_cu("SearchReplaceSingleBufferVisualSelection")
		:with_noremap()
		:with_desc("edit: Search-replace with selection within one line"),
	["v|<C-w>"] = map_cu("SearchReplaceWithinVisualSelectionCWord")
		:with_noremap()
		:with_desc("edit: Search-replace with selection within one line CWord"),

	-- Plugin: treehopper
	["o|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin: tabout
	["i|<A-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("edit: Goto end of pair"),
	["i|<A-h>"] = map_cmd("<Plug>(TaboutBackMulti)"):with_silent():with_noremap():with_desc("edit: Goto begin of pair"),

	-- Plugin suda.vim
	["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)
