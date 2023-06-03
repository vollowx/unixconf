return function()
	require("treesitter-context").setup({
		mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
	})
end
