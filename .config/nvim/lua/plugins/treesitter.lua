return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()

    require("nvim-treesitter").install({
      "bash", "c", "css", "dockerfile", "go", "haskell", "html",
      "javascript", "json", "lua", "python", "query", "rust", "vim", "yaml",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
