return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    routes = {
      -- basedpyright reports progress on nearly every keystroke; hide it
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            return vim.tbl_get(message.opts, "progress", "client") == "basedpyright"
          end,
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
