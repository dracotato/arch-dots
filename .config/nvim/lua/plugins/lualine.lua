return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    globalstatus = true,
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "◗", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {},
      lualine_x = { "encoding", "fileformat" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {
        function()
          return vim.fn.expand("%:~:h")
        end,
      },
      lualine_b = {
        "buffers",
      },
    },
  },
}
