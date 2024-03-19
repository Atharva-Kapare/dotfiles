-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.relativenumber = true
-- vim.cmd [[colorscheme tokyonight-night]]

return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {
			direction = "float",
			open_mapping = [[<c-t>]]
		},
		config = true
	},
	{
		-- For some colours
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 999,
		config = function()
			vim.cmd [[colorscheme tokyonight-night]]
		end,
	},
}
