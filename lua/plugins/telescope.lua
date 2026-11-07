return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },

		config = function()
			local previewers = require("telescope.previewers")
			local image_exts = { png = true, jpg = true, jpeg = true, gif = true, webp = true, bmp = true, avif = true, ico = true, tiff = true }

			-- Render images in the preview pane with chafa; everything else uses the default maker.
			local function previewer_maker(filepath, bufnr, opts)
				local ext = (filepath:match("%.([^./]+)$") or ""):lower()
				if not image_exts[ext] or vim.fn.executable("chafa") == 0 then
					return previewers.buffer_previewer_maker(filepath, bufnr, opts)
				end
				-- Telescope reuses preview buffers; a buffer can only host one terminal.
				if vim.b[bufnr].chafa_preview then
					return
				end
				vim.b[bufnr].chafa_preview = true
				local win = opts.winid
				local w = (win and vim.api.nvim_win_is_valid(win)) and vim.api.nvim_win_get_width(win) or 60
				local h = (win and vim.api.nvim_win_is_valid(win)) and vim.api.nvim_win_get_height(win) or 30
				vim.system({
					"chafa", "--format=symbols", "--animate=off", "--polite=on",
					"--size=" .. w .. "x" .. h, filepath,
				}, { text = true }, function(res)
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(bufnr) then
							return
						end
						local out = res.code == 0 and res.stdout or ("chafa failed: " .. (res.stderr or ""))
						local chan = vim.api.nvim_open_term(bufnr, {})
						vim.api.nvim_chan_send(chan, (out:gsub("\n", "\r\n")))
					end)
				end)
			end

			require("telescope").setup({
				defaults = { buffer_previewer_maker = previewer_maker },
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		end,
	},
}
