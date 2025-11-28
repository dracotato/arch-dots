return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        local always_hidden = { "..", ".venv", ".git", "__pycache__" }
        return vim.tbl_contains(always_hidden, name)
      end,
    },
    float = {},
  },
}
