return {
	{
		"nvim-neotest/neotest",
		-- lazy load on test commands or filetypes
		event = { "BufReadPost", "BufNewFile" },

		dependencies = {
			-- core deps
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- Go adapter
			"fredrikaverpil/neotest-golang",

			-- JS/TS adapter (vitest)
			"marilari88/neotest-vitest",
		},

		config = function()
			-- Treesitter installs for languages you need
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "go", "javascript", "typescript", "tsx" },
			})

			local neotest = require("neotest")
			vim.fn.sign_define("NeotestPassed", { text = ">", texthl = "DiagnosticOk" })
			vim.fn.sign_define("NeotestFailed", { text = "x", texthl = "DiagnosticError" })
			vim.fn.sign_define("NeotestRunning", { text = "~", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("NeotestSkipped", { text = "-", texthl = "DiagnosticInfo" })
			neotest.setup({
				-- config adapters
				adapters = {
					-- Go adapter
					require("neotest-golang")({
						-- optional: pass extra args to go test
						args = { "-v", "-count=1", "-timeout=60s" },
						-- for testify suites enable if needed
						-- testify_enabled = true,
					}),

					-- JS/TS vitest adapter
					require("neotest-vitest")({
						-- you can add options here if needed,
						-- like custom matcher, filter_dir, etc.
					}),
				},

				-- prefer module/workspace roots for Go projects
				root = function()
					return vim.fs.root(0, { "go.work", "go.mod", ".git" })
				end,

				diagnostic = { enabled = true },
				status = { virtual_text = true, signs = true },
				-- output = { open_on_run = true },
			})

			-- example keymaps (optional)
			local map = vim.keymap.set
			map("n", "<leader>ty", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })
			map("n", "<leader>tu", function()
				neotest.run.run(vim.fn.expand("%:p"))
			end, { desc = "Run current file" })
			map("n", "<leader>ta", function()
				neotest.run.run(vim.loop.cwd())
			end, { desc = "Run all tests" })
			map("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "Toggle test summary" })
			map("n", "<leader>to", function()
				neotest.output.open({ enter = true, last_run = true })
			end, { desc = "Show last test output" })
		end,
	},
}
