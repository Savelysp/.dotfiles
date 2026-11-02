return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "rust_analyzer",
      },
      -- Серверы включаются явно в lspconfig.lua, чтобы не было двух источников правды
      automatic_enable = false,
    },
  },
  {
    -- Не-LSP инструменты (mypy, debugpy, stylua и т.п.)
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "mypy",
        "debugpy",
        "stylua",
      },
    },
  },
}
