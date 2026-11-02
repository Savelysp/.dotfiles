return {
  "akinsho/toggleterm.nvim",
  version = "*",

  -- Загружаем лениво
  cmd = { "ToggleTerm", "TermExec", "ToggleTermToggleAll" },

  opts = {
    shade_terminals = true,
    -- Остальные полезные опции (по желанию):
    -- size = 20,
    -- direction = "horizontal",
    -- open_mapping = [[<C-\>]],
    -- persist_size = true,
    -- persist_mode = true,
  },
}
