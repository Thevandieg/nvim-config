return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")

      local snippets_path = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_path })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = snippets_path })

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
          return ""
        end
        return "<Tab>"
      end, { expr = true, silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
          return ""
        end
        return "<S-Tab>"
      end, { expr = true, silent = true })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local ls = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif ls.expand_or_jumpable() then
              ls.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif ls.jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
      -- 🔧 Autopairs integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  ---------------------
  -- Self close tags --
  ---------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
}
