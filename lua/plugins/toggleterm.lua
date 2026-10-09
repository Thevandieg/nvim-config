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

    -- Run a command in a floating terminal that stays open to show the output
    local function run_in_term(cmd, dir)
      vim.cmd("silent! w")
      Terminal:new({
        cmd = cmd,
        dir = dir,
        direction = "float",
        close_on_exit = false,
        start_in_insert = false,
      }):toggle()
    end

    -- First script under [project.scripts] in pyproject.toml
    local function pyproject_script(root)
      local in_scripts = false
      for line in io.lines(root .. "/pyproject.toml") do
        if line:match("^%[") then
          in_scripts = line:match("^%[project%.scripts%]") ~= nil
        elseif in_scripts then
          local name = line:match("^%s*([%w_%-%.]+)%s*=")
          if name then
            return name
          end
        end
      end
    end

    -- Run the project: `go run .` or `uv run <script>`
    vim.keymap.set("n", "<leader>rr", function()
      local root = vim.fs.root(0, { "go.mod", "pyproject.toml" })
      if not root then
        vim.notify("No go.mod or pyproject.toml found", vim.log.levels.WARN)
        return
      end
      if vim.uv.fs_stat(root .. "/go.mod") then
        run_in_term("go run .", root)
        return
      end
      local script = pyproject_script(root)
      if not script then
        vim.notify("No [project.scripts] entry in pyproject.toml", vim.log.levels.WARN)
        return
      end
      run_in_term("uv run " .. script, root)
    end, { desc = "Run project (go / uv)" })

    -- Run the current file
    vim.keymap.set("n", "<leader>rf", function()
      local runner = vim.bo.filetype == "go" and "go run " or "uv run "
      run_in_term(runner .. vim.fn.shellescape(vim.fn.expand("%:p")), vim.fn.expand("%:p:h"))
    end, { desc = "Run current file" })
  end,
}
