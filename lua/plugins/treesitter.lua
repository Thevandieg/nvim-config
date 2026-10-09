return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- master still provides nvim-treesitter.configs (main branch removed it)
    branch = "master",
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
      ensure_installed = {
        "lua",
        "yaml",
        "vim",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
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
    init = function()
      -- nvim-treesitter master registers its predicates/directives with
      -- `all = false` (one node per capture). Neovim 0.12 removed that option
      -- and always passes node lists, so e.g. markdown hover popups crash in
      -- get_range(). Adapt those handlers back to single nodes.
      if vim.fn.has("nvim-0.12") == 0 then
        return
      end
      local query = vim.treesitter.query
      for _, fn in ipairs({ "add_predicate", "add_directive" }) do
        local orig = query[fn]
        query[fn] = function(name, handler, opts)
          if type(opts) == "table" and opts.all == false then
            local h = handler
            handler = function(match, ...)
              local single = {}
              for id, nodes in pairs(match) do
                single[id] = type(nodes) == "table" and nodes[#nodes] or nodes
              end
              return h(single, ...)
            end
            opts = vim.tbl_extend("force", opts, { all = true })
          end
          return orig(name, handler, opts)
        end
      end
    end,
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
