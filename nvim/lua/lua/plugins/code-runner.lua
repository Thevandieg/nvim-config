return {
	{
		"CRAG666/code_runner.nvim",
		config = function()
			require("code_runner").setup({
				-- Mode to display output:  "term", "float", "tab", "toggleterm", "vimux", "better_term"
				mode = "term",

				-- Focus on runner window
				focus = true,

				-- Start in insert mode
				startinsert = true,

				-- Terminal settings
				term = {
					position = "bot", -- terminal position: "bot", "top", "vert", "float"
					size = 12, -- terminal size (height for horizontal, width for vertical)
				},

				-- Filetype configurations
				filetype = {
					go = "cd $dir && go run $fileName",
					javascript = "node $file",
					typescript = "deno run $file",
					python = "python3 -u $file",
					rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
					c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
					cpp = "cd $dir && g++ $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
				},
			})

			-- Keymaps
			local opts = { noremap = true, silent = true }

			-- Run the current file based on filetype
			vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", opts)
			vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", opts)

			-- Run in specific modes
			vim.keymap.set("n", "<leader>rt", ":RunFile tab<CR>", opts) -- run in new tab
			vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", opts) -- run project

			-- Close runner
			vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", opts)
		end,
	},
}
