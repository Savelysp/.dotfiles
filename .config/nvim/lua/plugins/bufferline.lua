return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",

  -- event = "BufReadPre",

  opts = {
    options = {
      mode = "buffers",           -- "buffers" — список открытых буферов, "tabs" — вкладки
      numbers = "none",           -- "none" | "ordinal" | "buffer_id" | "both"
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,

      indicator = {
        icon = "▎",               -- символ-индикатор текущего буфера
        style = "icon",           -- "icon" | "underline" | "none"
      },

      modified_icon    = "●",
      close_icon       = "",
      left_trunc_marker  = "",
      right_trunc_marker = "",
      max_name_length  = 18,
      max_prefix_length = 15,
      tab_size         = 18,

      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,

      -- Отступ под файловое дерево NvimTree
      offsets = {
        {
          filetype   = "NvimTree",
          text       = "File Explorer",
          highlight  = "Directory",
          text_align = "left",
        },
      },

      color_icons           = true,   -- цветные иконки типов файлов
      show_buffer_icons     = true,
      show_buffer_close_icons = true,
      show_close_icon       = true,
      show_tab_indicators   = true,
      persist_buffer_sort   = true,
      separator_style       = "thin", -- "thin" | "thick" | "slant"
      enforce_regular_tabs  = false,
      always_show_bufferline = true,
    },

    highlights = {
      -- Прозрачный фон всей панели bufferline
      fill = { bg = "None" },
    },
  },
} 
