vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.rnu = true

vim.o.clipboard = "unnamedplus"

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.laststatus = 3

vim.o.signcolumn = "yes"

vim.o.foldcolumn = "1"
vim.o.foldmethod = "indent"
vim.o.foldenable = false -- open folds on startup

vim.o.completeopt = "menu,menuone,noselect"

vim.o.virtualedit = "block"

vim.o.cursorline = true

vim.o.smoothscroll = true

vim.o.showmode = false

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = " ",
}

vim.o.inccommand = "split"

vim.o.scrolloff = 10

vim.o.confirm = true

-- vim.opt.cmdheight = 0

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
