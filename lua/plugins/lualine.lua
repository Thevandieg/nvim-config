-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--
--     config = function()
--       require("lualine").setup({
--         options = {
--           theme = "everforest",
--         },
--       })
--     end,
--   },
-- }
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "everforest",
				},
				sections = {
					lualine_x = {
						function()
							local reg = vim.fn.reg_recording()
							if reg == "" then
								return ""
							end
							return "Recording @" .. reg
						end,
					},
				},
			})

			-- 👇 Force update of lualine when macro starts/stops
			vim.api.nvim_create_autocmd("RecordingEnter", {
				callback = function()
					vim.defer_fn(function()
						require("lualine").refresh()
					end, 50)
				end,
			})

			vim.api.nvim_create_autocmd("RecordingLeave", {
				callback = function()
					vim.defer_fn(function()
						require("lualine").refresh()
					end, 50)
				end,
			})
		end,
	},
}
