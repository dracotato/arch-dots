return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    display = { theme = "catppuccin", flavor = "accent" },
    advanced = {
      discord = {
        reconnect = {
          enabled = true,
        },
      },
    },
    buttons = {
      {
        label = function(opts)
          return opts.repo_url and "View Repo"
        end,
        url = function(opts)
          return opts.repo_url
        end,
      },
    },
  },
}
