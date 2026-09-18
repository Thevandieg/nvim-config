-- Options & bootstrap
require("config.options")
require("config.lazy")

-- Keymaps: load on VeryLazy (after plugins register their defaults) so our
-- bindings win over plugin/Neovim defaults (<C-n> visual-multi, <C-l> redraw).
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.key-maps")
  end,
})
