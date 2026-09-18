return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim", -- Required dependency
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local status_ok, null_ls = pcall(require, "null-ls")
		if not status_ok then
			vim.notify("none-ls.nvim not loaded", vim.log.levels.ERROR)
			return
		end

		-- Add NVM bin to PATH
		local nvm_bin = os.getenv("HOME") .. "/.nvm/versions/node/v24.12.0/bin"
		if not string.find(vim.env.PATH, nvm_bin, 1, true) then
			vim.env.PATH = vim.env.PATH .. ":" .. nvm_bin
		end

		null_ls.setup({
			sources = {
				-- JSON formatting
				require("none-ls.formatting.jq"),

				-- Lua formatting
				null_ls.builtins.formatting.stylua,

				-- Prettier for JS/TS/CSS/HTML/etc
				null_ls.builtins.formatting.prettier.with({
					extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"css",
						"scss",
						"html",
						"json",
						"yaml",
						"yml",
						"markdown",
					},
				}),

				-- SQL formatting
				null_ls.builtins.formatting.sqlfluff.with({
					command = "/home/ivan/.local/bin/sqlfluff",
					extra_args = { "--dialect", "postgres" },
				}),

				-- YAML formatting
				null_ls.builtins.formatting.yamlfmt,
			},
		})

		-- Format and save keybinding
		vim.keymap.set("n", "<leader>gr", function()
			vim.lsp.buf.format({ async = false })
			vim.cmd("write")
		end, { desc = "Format and save buffer" })
	end,
}
