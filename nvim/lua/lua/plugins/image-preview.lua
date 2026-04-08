return {
	"nvim-telescope/telescope-media-files.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")

		-- Patch the plugin's vimg script to add iterm format flag
		-- This is needed because chafa needs -f iterm for proper WezTerm support
		-- WezTerm supports iTerm2 inline image protocol
		-- Find the script using the plugin's base directory
		local plugin_path = vim.fn.stdpath("data") .. "/lazy/telescope-media-files.nvim"
		-- Also check alternative paths
		if vim.fn.isdirectory(plugin_path) == 0 then
			plugin_path = vim.fn.stdpath("data") .. "/site/pack/*/start/telescope-media-files.nvim"
			local matches = vim.fn.glob(plugin_path, false, true)
			if #matches > 0 then
				plugin_path = matches[1]
			end
		end

		local vimg_script = plugin_path .. "/scripts/vimg"
		if vim.fn.filereadable(vimg_script) == 1 then
			-- Read the script
			local file = io.open(vimg_script, "r")
			if file then
				local content = file:read("*all")
				file:close()

				-- Check if already patched (contains format flag)
				if not string.find(content, "-f ") then
					-- Use symbols format (works in all terminals including WezTerm)
					-- This will show ASCII art representation of images
					content = string.gsub(
						content,
						'chafa --animate=off --center=on --clear --size',
						'chafa -f symbols --animate=off --center=on --clear --size'
					)

					-- Write back the patched script
					file = io.open(vimg_script, "w")
					if file then
						file:write(content)
						file:close()
						vim.notify("Patched telescope-media-files script for WezTerm support (symbols format)", vim.log.levels.INFO)
					end
				elseif string.find(content, "-f iterm") or string.find(content, "-f kitty") then
					-- Update from iterm/kitty to symbols for better compatibility
					content = string.gsub(
						content,
						'chafa -f iterm',
						'chafa -f symbols'
					)
					content = string.gsub(
						content,
						'chafa -f kitty',
						'chafa -f symbols'
					)
					file = io.open(vimg_script, "w")
					if file then
						file:write(content)
						file:close()
						vim.notify("Updated telescope-media-files script to use symbols format", vim.log.levels.INFO)
					end
				end
			end
		end

		-- Configure telescope extension
		telescope.setup({
			extensions = {
				media_files = {
					filetypes = { "png", "jpg", "jpeg", "webp", "pdf" },
					find_cmd = "fd", -- or "rg", "find", "fdfind"
					image_stretch = 250,
				},
			},
		})

		telescope.load_extension("media_files")

		vim.keymap.set("n", "<leader>fm", function()
			telescope.extensions.media_files.media_files()
		end, { desc = "Find media files" })
	end,
}
