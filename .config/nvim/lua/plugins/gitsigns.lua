return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    -- Символы в gutter (колонка слева от номеров строк)
    signs = {
      add          = { text = "+" },  -- добавленные строки
      change       = { text = "~" },  -- изменённые строки
      delete       = { text = "_" },  -- удалённые строки
      topdelete    = { text = "‾" },  -- удалённые строки в начале файла
      changedelete = { text = "~" },  -- изменённые и удалённые
      untracked    = { text = "┆" },  -- новые файлы, ещё не в git
    },
  },

  config = function(_, opts)
    local gs = require("gitsigns")
    gs.setup(opts)

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end

    -- Навигация по изменениям
    map("n", "]h", function() gs.nav_hunk("next") end, "Git: следующий хунк")
    map("n", "[h", function() gs.nav_hunk("prev") end, "Git: предыдущий хунк")

    -- Действия с хунками
    map("n", "<leader>hs", gs.stage_hunk, "Git: stage hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Git: reset hunk")
    map("n", "<leader>hp", gs.preview_hunk, "Git: preview hunk")
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Git: blame line")

    -- Действия с буфером
    map("n", "<leader>hS", gs.stage_buffer, "Git: stage buffer")
    map("n", "<leader>hR", gs.reset_buffer, "Git: reset buffer")
    map("n", "<leader>hu", gs.undo_stage_hunk, "Git: undo stage hunk")
  end,
}
