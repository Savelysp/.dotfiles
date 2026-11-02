local map = vim.keymap.set

--------------------------------------------------
-- Insert mode: перемещение курсора
--------------------------------------------------
map("i", "<C-b>", "<ESC>^i", { desc = "В начало строки" })
map("i", "<C-e>", "<End>", { desc = "В конец строки" })
map("i", "<C-h>", "<Left>", { desc = "Влево" })
map("i", "<C-l>", "<Right>", { desc = "Вправо" })
map("i", "<C-j>", "<Down>", { desc = "Вниз" })
map("i", "<C-k>", "<Up>", { desc = "Вверх" })
map("i", "jk", "<ESC>", { desc = "Выйти из Insert" })

--------------------------------------------------
-- Командный режим
--------------------------------------------------
map("n", ";", ":", { desc = "Командный режим" })

--------------------------------------------------
-- Окна
--------------------------------------------------
map("n", "<C-h>", "<C-w>h", { desc = "Окно влево" })
map("n", "<C-l>", "<C-w>l", { desc = "Окно вправо" })
map("n", "<C-j>", "<C-w>j", { desc = "Окно вниз" })
map("n", "<C-k>", "<C-w>k", { desc = "Окно вверх" })

--------------------------------------------------
-- Поиск и файл
--------------------------------------------------
map("n", "<leader>nh", "<cmd>noh<CR>", { desc = "Убрать подсветку поиска" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Сохранить файл" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Скопировать файл целиком" })

--------------------------------------------------
-- Нумерация строк
--------------------------------------------------
map("n", "<leader>nn", "<cmd>set nu!<CR>", { desc = "Переключить номера строк" })
map("n", "<leader>nr", "<cmd>set rnu!<CR>", { desc = "Переключить относительные номера" })

--------------------------------------------------
-- Комментирование
--------------------------------------------------
map("n", "<leader>/", "gcc", { desc = "Комментировать строку", remap = true })
map("v", "<leader>/", "gc", { desc = "Комментировать выделение", remap = true })

--------------------------------------------------
-- nvim-tree
--------------------------------------------------
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Дерево файлов: открыть/закрыть" })
map("n", "<leader>t", "<cmd>NvimTreeFocus<CR>", { desc = "Дерево файлов: фокус" })

--------------------------------------------------
-- Telescope
--------------------------------------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Файлы" })
map("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", { desc = "Поиск по тексту" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Буферы" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Справка" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Недавние файлы" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Поиск в текущем буфере" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Все файлы (включая скрытые и ignored)" }
)
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Метки" })

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git: коммиты" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git: статус" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git: ветки" })

map("n", "<leader>cs", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Цветовые схемы" })

--------------------------------------------------
-- Bufferline
--------------------------------------------------
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Следующий буфер" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Предыдущий буфер" })

map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Новый буфер" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Закрыть выбранный буфер" })
map(
  "n",
  "<leader>bC",
  "<cmd>BufferLineCloseLeft<CR><cmd>BufferLineCloseRight<CR>",
  { desc = "Закрыть все буферы, кроме текущего" }
)
map("n", "<leader>bl", "<cmd>BufferLineMoveNext<CR>", { desc = "Переместить буфер вправо" })
map("n", "<leader>bh", "<cmd>BufferLineMovePrev<CR>", { desc = "Переместить буфер влево" })
map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Выбрать буфер" })
map("n", "<leader>bs", "<cmd>BufferLineSortByTabs<CR>", { desc = "Сортировать буферы по вкладкам" })

for i = 1, 9 do
  map("n", "<leader>b" .. i, ("<cmd>BufferLineGoToBuffer %d<CR>"):format(i), { desc = "Буфер " .. i })
end

--------------------------------------------------
-- Вкладки
--------------------------------------------------
map("n", "<leader>wn", "<cmd>tabnew<CR>", { desc = "Новая вкладка" })
map("n", "<leader>wc", "<cmd>tabclose<CR>", { desc = "Закрыть вкладку" })
map("n", "<leader>wj", "<cmd>tabnext<CR>", { desc = "Следующая вкладка" })
map("n", "<leader>wk", "<cmd>tabprev<CR>", { desc = "Предыдущая вкладка" })

--------------------------------------------------
-- Терминал
--------------------------------------------------
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Выйти из режима терминала" })
map("n", "<leader>sf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Терминал: float" })
map("n", "<leader>sh", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Терминал: снизу" })
map("n", "<leader>sv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Терминал: справа" })
map("n", "<leader>sc", "<cmd>ToggleTermToggleAll<CR>", { desc = "Терминал: закрыть все" })
