-- Статусная строка.
--
-- Как читать этот файл:
--   1. Вспомогательные функции.
--   2. Условия показа.
--   3. Отдельные компоненты (каждый — небольшая таблица).
--   4. Сборка: lualine_c — слева, lualine_x — справа.
--
-- Чтобы переставить блоки, меняйте порядок в sections внизу.
-- Чтобы изменить цвета — lua/util/palette.lua.

local c = require("util.palette")

--------------------------------------------------
-- 1. Вспомогательные функции
--------------------------------------------------

-- Цвет иконки режима.
-- vim.fn.mode() возвращает не только "n"/"i", но и управляющие
-- последовательности: "\22" — visual block, "\19" — select line.
local function mode_color()
  local by_mode = {
    n = c.red,
    no = c.red,
    ["!"] = c.red,
    i = c.green,
    ic = c.yellow,
    v = c.blue,
    V = c.blue,
    ["\22"] = c.blue,
    c = c.magenta,
    s = c.orange,
    S = c.orange,
    ["\19"] = c.orange,
    R = c.violet,
    Rv = c.violet,
    cv = c.red,
    ce = c.red,
    r = c.cyan,
    rm = c.cyan,
    ["r?"] = c.cyan,
    t = c.red,
  }

  return { fg = by_mode[vim.fn.mode()] or c.fg }
end

-- Имя LSP-клиента, привязанного к текущему буферу ("" — если нет).
local function lsp_name()
  local filetype = vim.bo.filetype
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config.filetypes and vim.list_contains(client.config.filetypes, filetype) then
      return client.name
    end
  end
  return ""
end

--------------------------------------------------
-- 2. Условия показа
--------------------------------------------------

local conditions = {
  -- Скрывать имя файла в пустом буфере (dashboard, :enew)
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,

  -- Скрывать второстепенные блоки в узком окне
  wide_enough = function()
    return vim.o.columns > 80
  end,
}

--------------------------------------------------
-- 3. Компоненты
--------------------------------------------------

-- Цветной «язычок» слева
local left_edge = {
  function() return "▊" end,
  color = { fg = c.blue },
  padding = { left = 0, right = 1 },
}

-- Иконка Neovim, цвет зависит от режима
local mode = {
  function() return "\u{f30c}" end,
  color = mode_color,
  padding = { right = 1 },
}

local filesize = {
  "filesize",
  cond = conditions.buffer_not_empty,
}

local filename = {
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = c.magenta, gui = "bold" },
}

local location = { "location" }

local progress = {
  "progress",
  color = { fg = c.fg, gui = "bold" },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = "\u{f057} ",
    warn = "\u{f071} ",
    info = "\u{f06a} ",
  },
  diagnostics_color = {
    error = { fg = c.red },
    warn = { fg = c.yellow },
    info = { fg = c.cyan },
  },
}

-- Имя активного LSP; скрыт, если LSP не подключён
local lsp = {
  lsp_name,
  icon = "\u{f085} LSP:",
  color = { fg = c.white, gui = "bold" },
  cond = function()
    return lsp_name() ~= ""
  end,
}

local encoding = {
  "o:encoding",
  fmt = string.upper,
  cond = conditions.wide_enough,
  color = { fg = c.green, gui = "bold" },
}

local fileformat = {
  "fileformat",
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = c.green, gui = "bold" },
}

local branch = {
  "branch",
  icon = "\u{f47f}",
  color = { fg = c.violet, gui = "bold" },
}

local diff = {
  "diff",
  symbols = {
    added = "\u{f0fe} ",
    modified = "\u{f0764} ",
    removed = "\u{f146} ",
  },
  diff_color = {
    added = { fg = c.green },
    modified = { fg = c.orange },
    removed = { fg = c.red },
  },
  cond = conditions.wide_enough,
}

-- Цветной «язычок» справа
local right_edge = {
  function() return "▊" end,
  color = { fg = c.blue },
  padding = { left = 1 },
}

--------------------------------------------------
-- 4. Сборка
--------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  priority = 900,

  opts = {
    options = {
      theme = {
        normal = { c = { fg = c.fg, bg = c.bg } },
        inactive = { c = { fg = c.dim, bg = c.bg } },
      },
      component_separators = "",
      section_separators = "",
      globalstatus = true,
      disabled_filetypes = { "dashboard" },
      ignore_focus = { "NvimTree" },
    },

    sections = {
      lualine_a = {},
      lualine_b = {},

      -- Слева: режим · размер · файл · позиция · прогресс · диагностика
      lualine_c = {
        left_edge,
        mode,
        filesize,
        filename,
        location,
        progress,
        diagnostics,
      },

      -- Справа: LSP · кодировка · формат · ветка · diff
      lualine_x = {
        lsp,
        encoding,
        fileformat,
        branch,
        diff,
        right_edge,
      },

      lualine_y = {},
      lualine_z = {},
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
