return {
  "nickjvandyke/opencode.nvim",
  -- No `version`: track main, which supports OpenCode v2 (stable releases are v1-only).
  config = function()
    -- OpenCode v2 keeps a background service running after the TUI is closed.
    -- The plugin finds that service and talks to it headlessly, so it never
    -- reopens the TUI by itself; toggle it with <leader>ot.
    local term_buf

    local function toggle()
      if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        local win = vim.fn.bufwinid(term_buf)
        if win ~= -1 then
          vim.api.nvim_win_close(win, false)
        else
          vim.cmd("vsplit")
          vim.api.nvim_win_set_buf(0, term_buf)
        end
        return
      end
      vim.cmd("vsplit term://opencode")
      term_buf = vim.api.nvim_get_current_buf()
      vim.bo[term_buf].bufhidden = "hide"
    end

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }
    -- Functions can't go through vim.g, so set start on the merged opts.
    require("opencode.config").opts.server.start = function()
      toggle()
      vim.cmd("wincmd p")
    end

    -- <C-a> is the tmux prefix, so OpenCode lives under <leader>o.
    vim.keymap.set({ "n" },      "<leader>ot", toggle,                                                          { desc = "Toggle OpenCode TUI" })
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end,                    { desc = "Ask OpenCode…" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,                          { desc = "Select OpenCode…" })
    vim.keymap.set({ "n", "x" }, "go",      function() return require("opencode").operator("@this ") end,         { desc = "Append range to OpenCode", expr = true })
    vim.keymap.set({ "n" },      "goo",     function() return require("opencode").operator("@this ") .. "_" end,  { desc = "Append line to OpenCode", expr = true })
    vim.keymap.set({ "n" },      "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
    vim.keymap.set({ "n" },      "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
  end,
}
