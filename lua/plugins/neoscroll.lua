return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			hide_cursor = true,
			stop_eof = true, -- Stop scrolling at EndOfFile
			respect_scrolloff = false, -- If true, will not scroll if cursor within 'scrolloff'
			-- (Set to false if you want it to always center/scroll smoothly)

			-- Define which keys trigger smooth scrolling:
			mappings = {
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-f>",
				"zt",
				"zz",
				"zb",
			},

			-- Animation speed and style:
			performance_mode = false, -- Set to true for lower CPU usage (less smooth)
			scroll_down_easing = "quadratic", -- Easing function for scrolling down
			scroll_up_easing = "quadratic",
			scroll_down_velocity_factor = 1,
			scroll_up_velocity_factor = 1,
		})
	end,
}
