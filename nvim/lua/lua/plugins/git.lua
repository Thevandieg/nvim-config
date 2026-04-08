return {

	-- =========================
	-- Vim Fugitive
	-- =========================
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"G",
			"Gstatus",
			"Gcommit",
			"Gpush",
			"Gpull",
			"Gdiffsplit",
		},
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
		},
	},

	-- =========================
	-- Git Signs
	-- =========================
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 500,
				virt_text_pos = "eol",
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next hunk")
				map("n", "[h", gs.prev_hunk, "Prev hunk")
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
				map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hb", gs.blame_line, "Blame line")
				map("n", "<leader>hd", gs.diffthis, "Diff this")
			end,
		},
	},

	-- =========================
	-- Diffview
	-- =========================
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFileHistory",
		},
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
			{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},
	{
		"isakbm/gitgraph.nvim",
		opts = {
			git_cmd = "git",
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gk",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},
}
