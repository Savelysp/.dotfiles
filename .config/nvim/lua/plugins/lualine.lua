return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Загружаем при старте: статусная строка нужна сразу
  lazy = false,
  priority = 900, -- ниже темы, но выше обычных плагинов

  -- Вся конфигурация в opts — lazy.nvim сам вызовет setup()
  opts = function()
    -- Палитра цветов
    local colors = {
      bg       = "#202328",
      fg       = "#bbc2cf",
      yellow   = "#ECBE7B",
      cyan     = "#008080",
      green    = "#98be65",
      orange   = "#FF8800",
      violet   = "#a9a1e1",
      magenta  = "#c678dd",
      blue     = "#51afef",
      red      = "#ec5f67",
    }

    -- Условия отображения компонентов
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Секции собираем сразу в таблице, без хелперов ins_left/ins_right
    local sections = {
      -- Слева: разделитель, режим, размер, имя файла, позиция, прогресс, диагностика
      lualine_c = {
        { function() return "▊" end, color = { fg = colors.blue }, padding = { left = 0, right = 1 } },

        {
          function() return "" end,
          color = function()
            local mode_color = {
              n = colors.red,
              i = colors.green,
              v = colors.blue,
              [""] = colors.blue,
              V = colors.blue,
              c = colors.magenta,
              no = colors.red,
              s = colors.orange,
              S = colors.orange,
              [""] = colors.orange,
              ic = colors.yellow,
              R = colors.violet,
              Rv = colors.violet,
              cv = colors.red,
              ce = colors.red,
              r = colors.cyan,
              rm = colors.cyan,
              ["r?"] = colors.cyan,
              ["!"] = colors.red,
              t = colors.red,
            }
            return { fg = mode_color[vim.fn.mode()] }
          end,
          padding = { right = 1 },
        },

        { "filesize", cond = conditions.buffer_not_empty },
        { "filename", cond = conditions.buffer_not_empty, color = { fg = colors.magenta, gui = "bold" } },
        { "location" },
        { "progress", color = { fg = colors.fg, gui = "bold" } },

        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " " },
          diagnostics_color = {
            error = { fg = colors.red },
            warn  = { fg = colors.yellow },
            info  = { fg = colors.cyan },
          },
        },

        { function() return "%=" end }, -- растяжка между левой и правой частями

        {
          -- Имя активного LSP-клиента
          function()
            local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then return "No Active Lsp" end
            for _, client in ipairs(clients) do
              if client.config.filetypes and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return "No Active Lsp"
          end,
          icon = " LSP:",
          color = { fg = "#ffffff", gui = "bold" },
        },
      },

      -- Справа: кодировка, формат файла, ветка, diff, разделитель
      lualine_x = {
        {
          "o:encoding",
          fmt = string.upper,
          cond = conditions.hide_in_width,
          color = { fg = colors.green, gui = "bold" },
        },
        {
          "fileformat",
          fmt = string.upper,
          icons_enabled = false,
          color = { fg = colors.green, gui = "bold" },
        },
        { "branch", icon = "", color = { fg = colors.violet, gui = "bold" } },
        {
          "diff",
          symbols = { added = " ", modified = "󰝤 ", removed = " " },
          diff_color = {
            added    = { fg = colors.green },
            modified = { fg = colors.orange },
            removed  = { fg = colors.red },
          },
          cond = conditions.hide_in_width,
        },
        { function() return "▊" end, color = { fg = colors.blue }, padding = { left = 1 } },
      },

      -- Пустые секции отключают стандартные компоненты
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
    }

    return {
      options = {
        disabled_filetypes = { "dashboard" },
        ignore_focus = { "NvimTree" },
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        theme = {
          normal   = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = sections,
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }
  end,
}

-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   lazy = false,
--   priority = 900,
--
--   opts = function()
--     -- ═══════════════════════════════════════════════════════════════════════
--     -- 1. ЦВЕТА — меняйте здесь, если хотите другую палитру
--     -- ═══════════════════════════════════════════════════════════════════════
--     local c = {
--       bg     = "#202328", -- фон строки
--       fg     = "#bbc2cf", -- обычный текст
--       dim    = "#5c6370", -- приглушённый (неактивные окна)
--       blue   = "#51afef",
--       green  = "#98be65",
--       yellow = "#ECBE7B",
--       orange = "#FF8800",
--       red    = "#ec5f67",
--       violet = "#a9a1e1",
--       cyan   = "#008080",
--       pink   = "#c678dd",
--     }
--
--     -- ═══════════════════════════════════════════════════════════════════════
--     -- 2. КОМПОНЕНТЫ — каждый блок можно удалить или переставить местами
--     -- ═══════════════════════════════════════════════════════════════════════
--
--     -- Левый край: цветной «язычок»
--     local left_edge = {
--       function() return "▊" end,
--       color = { fg = c.blue },
--       padding = { left = 0, right = 1 },
--     }
--
--     -- Иконка режима (меняет цвет в зависимости от mode)
--     local mode = {
--       function() return "" end,
--       color = function()
--         local map = {
--           n = c.red,   i = c.green,  v = c.blue,   V = c.blue,
--           c = c.pink,  R = c.violet, r = c.cyan,   t = c.red,
--           ["!"] = c.red, no = c.red, s = c.orange, S = c.orange,
--         }
--         return { fg = map[vim.fn.mode()] or c.fg }
--       end,
--       padding = { right = 1 },
--     }
--
--     -- Имя файла + индикатор изменений
--     local filename = {
--       "filename",
--       color = { fg = c.pink, gui = "bold" },
--       symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
--       cond = function() return vim.fn.expand("%:t") ~= "" end,
--     }
--
--     -- Размер файла (только для непустых буферов)
--     local filesize = {
--       "filesize",
--       color = { fg = c.fg },
--       cond = function() return vim.fn.expand("%:t") ~= "" end,
--     }
--
--     -- Позиция курсора (строка:колонка)
--     local location = { "location", color = { fg = c.cyan } }
--
--     -- Прогресс по файлу (%)
--     local progress = { "progress", color = { fg = c.fg, gui = "bold" } }
--
--     -- Ошибки/предупреждения от LSP
--     local diagnostics = {
--       "diagnostics",
--       sources = { "nvim_diagnostic" },
--       symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
--       diagnostics_color = {
--         error = { fg = c.red },
--         warn  = { fg = c.yellow },
--         info  = { fg = c.cyan },
--         hint  = { fg = c.violet },
--       },
--     }
--
--     -- Имя активного LSP-сервера (скрыт, если LSP нет)
--     local lsp = {
--       function()
--         local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
--         for _, client in ipairs(vim.lsp.get_clients()) do
--           if client.config.filetypes and vim.fn.index(client.config.filetypes, ft) ~= -1 then
--             return " " .. client.name
--           end
--         end
--         return ""
--       end,
--       color = { fg = "#ffffff", gui = "bold" },
--     }
--
--     -- Кодировка файла (UTF-8 и т.д.)
--     local encoding = {
--       "o:encoding",
--       fmt = string.upper,
--       color = { fg = c.green },
--     }
--
--     -- Формат файла (UNIX/DOS)
--     local fileformat = {
--       "fileformat",
--       fmt = string.upper,
--       icons_enabled = false,
--       color = { fg = c.green },
--     }
--
--     -- Ветка git (скрыта вне репозитория)
--     local branch = {
--       "branch",
--       icon = "",
--       color = { fg = c.violet, gui = "bold" },
--       cond = function()
--         local p = vim.fn.expand("%:p:h")
--         local g = vim.fn.finddir(".git", p .. ";")
--         return g and #g > 0 and #g < #p
--       end,
--     }
--
--     -- Изменения git (+/-/~)
--     local diff = {
--       "diff",
--       symbols = { added = " ", modified = "󰝤 ", removed = " " },
--       diff_color = {
--         added    = { fg = c.green },
--         modified = { fg = c.orange },
--         removed  = { fg = c.red },
--       },
--       cond = function()
--         local p = vim.fn.expand("%:p:h")
--         local g = vim.fn.finddir(".git", p .. ";")
--         return g and #g > 0 and #g < #p
--       end,
--     }
--
--     -- Правый край: цветной «язычок»
--     local right_edge = {
--       function() return "▊" end,
--       color = { fg = c.blue },
--       padding = { left = 1 },
--     }
--
--     -- Тонкий разделитель между блоками
--     local sep = {
--       function() return "│" end,
--       color = { fg = c.dim },
--       padding = { left = 1, right = 1 },
--     }
--
--     -- ═══════════════════════════════════════════════════════════════════════
--     -- 3. СБОРКА — просто перечисляйте компоненты в нужном порядке
--     -- ═══════════════════════════════════════════════════════════════════════
--     return {
--       options = {
--         theme = {
--           normal   = { c = { fg = c.fg, bg = c.bg } },
--           inactive = { c = { fg = c.dim, bg = c.bg } },
--         },
--         component_separators = "",
--         section_separators   = "",
--         globalstatus = true,
--         disabled_filetypes = { "dashboard", "alpha", "NvimTree" },
--         ignore_focus = { "NvimTree" },
--       },
--
--       sections = {
--         -- Пустые секции отключают стандартные компоненты lualine
--         lualine_a = {},
--         lualine_b = {},
--         lualine_y = {},
--         lualine_z = {},
--
--         -- Левая часть: [▊] [режим] [файл] [размер] │ [позиция] [прогресс] │ [диагностика] ... [LSP]
--         lualine_c = {
--           left_edge,
--           mode,
--           filename,
--           filesize,
--           sep,
--           location,
--           progress,
--           sep,
--           diagnostics,
--           { function() return "%=" end }, -- растяжка: всё после уедет вправо
--           lsp,
--         },
--
--         -- Правая часть: [кодировка] [формат] │ [ветка] [diff] [▊]
--         lualine_x = {
--           encoding,
--           fileformat,
--           sep,
--           branch,
--           diff,
--           right_edge,
--         },
--       },
--
--       inactive_sections = {
--         lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {},
--         lualine_c = { filename },  -- в неактивных окнах показываем только имя файла
--         lualine_x = {},
--       },
--     }
--   end,
-- }
