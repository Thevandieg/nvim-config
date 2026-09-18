return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    enabled = false,
    opts = {
      prompts = {
        Rename = {
          prompt = "Please rename the variable correctly given the context",
          selection = function(source)
            local select = require("CopilotChat.select")
            return select.visual(source)
          end,
        },
      },
    },
  },
}
