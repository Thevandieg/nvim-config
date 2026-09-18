return {
	"mg979/vim-visual-multi",
	branch = "master",
	lazy = false,
	init = function()
		-- vim-visual-multi defaults to <C-n> for the multi-selector, which
		-- clashes with the window/file-tree toggle. Move it to <C-s>.
		local maps = vim.g.VM_maps or {}
		maps["Find Under"] = "<C-s>"
		maps["Find Subword Under"] = "<C-s>"
		vim.g.VM_maps = maps
	end,
}
