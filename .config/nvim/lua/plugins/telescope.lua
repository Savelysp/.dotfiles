return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- Ленивая загрузка
  cmd = "Telescope",

  opts = {
    defaults = {
      -- Префикс строки ввода
      prompt_prefix = "  ",
      -- Символ, отмечающий текущий выбранный элемент
      selection_caret = ">",
      -- Префикс для остальных элементов списка
      entry_prefix = " ",
      -- Сортировка сверху вниз (совпадает с визуальным порядком)
      sorting_strategy = "ascending",

      -- Настройки расположения окна
      layout_config = {
        horizontal = {
          -- Поле ввода сверху, результаты снизу
          prompt_position = "top",
          -- Ширина окна предпросмотра — 55% от общего
          preview_width = 0.55,
        },
        width = 0.87, -- Ширина всего окна — 87% экрана
        height = 0.80, -- Высота всего окна — 80% экрана
      },
    },
  },
}
