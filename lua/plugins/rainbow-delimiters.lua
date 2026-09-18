return {
  "HiPhish/rainbow-delimiters.nvim",
  init = function()
    local rainbow_delimiters = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        commonlisp = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterCyan",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterRed",
      },
    }
  end,
}
