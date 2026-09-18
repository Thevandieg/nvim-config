vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set splitright")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 4
vim.opt.termguicolors = true
vim.opt.showtabline = 7
vim.opt.scrolloff = 17

vim.opt.cursorline = true
vim.o.termguicolors = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable arrow keys in insert and normal mode
for _, mode in ipairs({ "n", "i", "v" }) do
	for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
		vim.api.nvim_set_keymap(mode, key, "<Nop>", { noremap = true })
	end
end

-- auto refresh explorer
vim.opt.autoread = true
