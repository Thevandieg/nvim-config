return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",   -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require("barbar").setup({
      animation = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      insert_at_end = false,
      sidebar_filetypes = {
        ["neo-tree"] = { event = "BufWinLeave", text = "󰙅 Explorer" },
        NvimTree = true,
        undotree = { text = "Undotree" },
        ["neo-tree-popup"] = { text = "" },
      },
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = "✘",
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        filetype = {
          enabled = true,
        },
        separator = { left = "▎", right = "" },
        modified = { button = "●" },
        pinned = { button = "", filename = true },
        alternate = { enabled = true },
      },
    })
  end,
}
