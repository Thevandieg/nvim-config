return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
			highlight = { "Function", "Label" }, -- highlights scope guides using syntax colors
			include = {
				node_type = {
					["*"] = {
						"class",
						"function",
						"method",
						"if_statement",
						"for_statement",
						"while_statement",
					},
				},
			},
		},
		whitespace = {
			remove_blankline_trail = true,
		},
		exclude = {
			filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy" },
			buftypes = { "terminal", "nofile" },
		},
	},
}
