return {
  "nvim-tree/nvim-tree.lua",

  -- иконки файлов 
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- Ленивая загрузка
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },  

  opts = {
    -- Отключаем стандартный netrw и перехватываем управление
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,

    -- Автоматически обновлять фокус на файле, который открыт в данный момент
    update_focused_file = {
      enable = true,
      update_root = false,
    },

    -- Настройки отображения дерева
    view = {
      width = 25,
      preserve_window_proportions = true,
    },

    -- Настройки рендеринга (внешний вид)
    renderer = {
      highlight_git = true,               -- Подсветка файлов с изменениями Git
      indent_markers = { enable = true }, -- Маркеры отступов для вложенных папок

      icons = {
        glyphs = {
          default = "󰈚",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
          },
          git = {
            unmerged = "",
          },
        },
      },
    },

    filters = {
      dotfiles = false,       -- Показывать файлы, начинающиеся с точки
      git_ignored = false,    -- Показывать файлы, игнорируемые Git
    },
  },
}
