return {
	"michaelb/sniprun",
	build = "bash ./install.sh",
	config = function()
		require("sniprun").setup({
			display = { "TempFloatingWindow", "VirtualTextOk", "VirtualTextErr" },
			repl_enable = { "Python3_original", "JS_TS_deno", "Lua_nvim" },
			-- Remove Go from here - it doesn't support REPL!
		})

		-- sniprun keymaps (for quick snippets)
		vim.keymap.set("n", "<leader>sl", ": SnipRun<CR>", { desc = "Snip:  Run line" })
		vim.keymap.set("v", "<leader>s", ":'<,'>SnipRun<CR>", { desc = "Snip: Run selection" })
	end,
}
