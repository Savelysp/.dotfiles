return {
  "lewis6991/gitsigns.nvim",

  event = { "BufReadPre", "BufNewFile" },

  opts = {
    -- Символы, отображаемые в gutter (колонка слева от номеров строк)
    signs = {
      add          = { text = "+" },  -- Добавленные строки
      change       = { text = "~" },  -- Изменённые строки
      delete       = { text = "_" },  -- Удалённые строки
      topdelete    = { text = "‾" },  -- Удалённые строки в начале файла
      changedelete = { text = "~" },  -- Строки, которые и изменены, и удалены
      untracked    = { text = "┆" },  -- Неотслеживаемые файлы (новые, ещё не в Git)
    },
  },
}
