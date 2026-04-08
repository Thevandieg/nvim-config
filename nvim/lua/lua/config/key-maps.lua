local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- enable clipboard shortcuts
keymap("v", "<C-c>", '"+y', opts)
keymap("n", "<C-v>", '"+p', opts)

-- duplicate line
keymap("n", "<leader>dd", "yyp", opts)

-- Move lines up and down
keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
keymap("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
keymap("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

--Navigation
keymap("n", "n", "nzzzv")

-- window
keymap("n", "<C-o>", "<C-w>p", opts) -- Toggle windows
keymap("n", "<C-h>", "<C-w>h", opts) -- left
keymap("n", "<C-j>", "<C-w>j", opts) -- down
keymap("n", "<C-k>", "<C-w>k", opts) -- up
keymap("n", "<C-l>", "<C-w>l", opts) -- right

-- terminal window
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Terminal mode shortcuts
keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

-- Neotree
keymap("n", "<C-n>", ":Neotree toggle<CR>", opts)

-- Clear search
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-----------------------
---- -- barbar -- -----
-----------------------
-- Move to previous/next buffer
keymap("n", "<Tab>", ":BufferNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", opts)

-- Re-order buffers
keymap("n", "<leader><", ":BufferMovePrevious<CR>", opts)
keymap("n", "<leader>>", ":BufferMoveNext<CR>", opts)

-- Pin/unpin buffer
keymap("n", "<leader>bp", ":BufferPin<CR>", opts)

-- Close buffer
keymap("n", "<leader>bc", ":BufferClose<CR>", opts)
keymap("n", "<leader>bo", ":BufferCloseAllButCurrent<CR>", opts)
keymap("n", "<leader>bl", ":BufferCloseBuffersLeft<CR>", opts)
keymap("n", "<leader>br", ":BufferCloseBuffersRight<CR>", opts)

-- Magic buffer-picking mode (like Telescope for buffers)
keymap("n", "<leader>bb", ":BufferPick<CR>", opts)

-- Jump to buffer [1-9]
for i = 1, 9 do
	keymap("n", "<leader>" .. i, ":BufferGoto " .. i .. "<CR>", opts)
end

-- ----------------------
-- Generate documentation
-- ----------------------
-- keymap("n", "<Leader>'", ":lua require('neogen').generate()<CR>", opts)

-- Treesj toggle
keymap("n", "<leader>m", require("treesj").toggle)

-- LSP helpers
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "go", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
