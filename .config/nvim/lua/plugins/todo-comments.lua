return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Подсветка нужна только когда открыт буфер, нет смысла грузить при старте
  event = { "BufReadPost", "BufNewFile" },
}
