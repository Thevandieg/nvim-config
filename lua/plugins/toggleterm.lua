return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 12
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
      shell = "fish", -- your preferred shell
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    -- Smart terminal toggling in current buffer's dir
    local function smart_toggle_term(opts)
      local term = Terminal:new({
        direction = opts.direction or "float",
        dir = vim.fn.expand("%:p:h"), -- ✅ get buffer's dir at call time
        hidden = true,
        close_on_exit = true,
        start_in_insert = true,
      })
      term:toggle()
    end

    -- Custom keymaps using smart terminal
    vim.keymap.set("n", "<leader>tt", function()
      smart_toggle_term({ direction = "horizontal" })
    end, { desc = "Toggle horizontal terminal in buffer dir" })

    vim.keymap.set("n", "<leader>tv", function()
      smart_toggle_term({ direction = "vertical" })
    end, { desc = "Toggle vertical terminal in buffer dir" })

    vim.keymap.set("n", "<leader>tf", function()
      smart_toggle_term({ direction = "float" })
    end, { desc = "Toggle floating terminal in buffer dir" })

    vim.keymap.set("n", "<leader>tn", function()
      smart_toggle_term({ direction = "tab" })
    end, { desc = "Toggle tab terminal in buffer dir" })
  end,
}
