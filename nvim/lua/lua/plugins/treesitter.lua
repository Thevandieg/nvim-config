return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      context_commentstring = {
        enable = true,
      },
      ensure_installed = {
        "lua",
        "yaml",
        "vim",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "go",
        "java",
        "python",
        "rust",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      auto_install = true,
      additional_vim_regex_highlighting = false,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        mode = "cursor",
        patterns = {
          default = {
            "class",
            "function",
            "method",
          },
        },
        zindex = 20,
        separator = nil,
      })

      vim.cmd([[highlight TreesitterContext guibg=NONE]])
    end,
  },
}
