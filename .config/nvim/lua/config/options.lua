local opt = vim.opt
local o = vim.o
local g = vim.g

--------------------------------------------------
-- Leader (должен быть задан до загрузки маппингов)
--------------------------------------------------
g.mapleader = " "
g.maplocalleader = "\\"

--------------------------------------------------
-- Внешний вид
--------------------------------------------------
opt.termguicolors = true
o.laststatus = 3
o.showmode = false
o.cursorline = true
o.cursorlineopt = "number"
o.number = true
o.relativenumber = true
o.numberwidth = 3
o.ruler = false
o.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.shortmess:append "sI"

--------------------------------------------------
-- Отступы
--------------------------------------------------
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.autoindent = true

--------------------------------------------------
-- Поиск
--------------------------------------------------
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

--------------------------------------------------
-- Буфер обмена, мышь, прокрутка
--------------------------------------------------
o.clipboard = "unnamedplus"
o.mouse = "a"
o.scrolloff = 8
o.sidescrolloff = 8
opt.whichwrap:append "<>[]hl"

--------------------------------------------------
-- Сплиты
--------------------------------------------------
o.splitbelow = true
o.splitright = true

--------------------------------------------------
-- Тайминги и файлы
--------------------------------------------------
o.timeoutlen = 300
o.updatetime = 250
o.undofile = true
o.confirm = true

--------------------------------------------------
-- Дополнение
--------------------------------------------------
o.completeopt = "menu,menuone,noselect"

--------------------------------------------------
-- Провайдеры Neovim (не нужны, ускоряют загрузку)
--------------------------------------------------
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
