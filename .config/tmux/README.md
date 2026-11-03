# tmux

Конфигурация tmux для Alacritty на Wayland (niri). Проверена на tmux 3.7b.

- Конфиг: [`tmux.conf`](./tmux.conf)
- Префикс: `C-b`
- Перезагрузка: `prefix + r`
- Плагины: TPM, tmux-resurrect, tmux-continuum, Catppuccin

## Требования

- tmux 3.4+ (используются `status-justify absolute-centre`, `pane-border-lines`,
  `allow-passthrough` и `extended-keys`)
- Nerd Font — для иконок в статус-баре
- `wl-clipboard` — для копирования в системный буфер на Wayland
- Alacritty или другой терминал с поддержкой RGB/OSC 52

## Установка с нуля

TPM и плагины живут в `~/.config/tmux/plugins`, рядом с конфигом:

```bash
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux
```

Внутри tmux установить плагины:

```text
prefix + I
```

После установки Catppuccin перезагрузить конфиг:

```text
prefix + r
```

Путь `TMUX_PLUGIN_MANAGER_PATH` задан в конфиге явно:

```tmux
set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.config/tmux/plugins/"
```

Если TPM уже установлен в другом месте, либо перенеси его в
`~/.config/tmux/plugins/tpm`, либо измени эту строку в `tmux.conf`.

## Клавиши

`prefix` — это `C-b`.

| Клавиши | Действие |
|---|---|
| `prefix + r` | перезагрузить конфиг |
| `prefix + \|` | разделить панель по горизонтали |
| `prefix + -` | разделить панель по вертикали |
| `prefix + h/j/k/l` | перейти к панели влево/вниз/вверх/вправо |
| `prefix + C-h/j/k/l` | изменить размер панели (можно удерживать) |
| `prefix + c` | новое окно в текущем каталоге |
| `prefix + X` | убить сессию с подтверждением |
| `prefix + z` | развернуть/свернуть панель |
| `prefix + x` | убить панель с подтверждением |
| `prefix + &` | убить окно с подтверждением |
| `prefix + s` | дерево сессий и окон |
| `prefix + L` | вернуться к последней сессии |
| `prefix + d` | отключиться (detach) |
| `prefix + [` | войти в copy-mode |
| `prefix + 1..9` | переключиться на окно с номером |
| `prefix + стрелки` | переключиться на панель |
| `prefix + M-стрелки` | изменить размер панели |

В copy-mode (vi):

| Клавиши | Действие |
|---|---|
| `v` | начать выделение |
| `V` | выделить строку |
| `y` | скопировать выделенное в системный буфер |
| `/`, `?` | поиск вперёд/назад |
| `Enter` | скопировать выделенное и выйти |
| `q` / `Esc` | выйти из copy-mode |

Мышь: клик выбирает панель, перетаскивание выделяет текст, колесо прокручивает
историю. Копирование мышью настроено на `wl-copy`.

`prefix + r` переопределяет стандартный `refresh-client`; это осознанно,
потому что перезагрузка конфига используется чаще.

## Как устроен конфиг

Файл разбит на секции:

1. **Сервер и терминал** — `TERM`, `escape-time`, `focus-events`,
   `extended-keys`, `set-clipboard`, `terminal-features`, passthrough.
2. **Поведение** — нумерация, `renumber-windows`, scrollback, мышь,
   copy-mode, автопереименование окон, активность.
3. **Клавиши** — split, навигация, resize, reload, kill-session.
4. **Copy-mode и буфер обмена** — vi-выделение и `wl-copy`.
5. **Плагины** — объявления TPM и настройки resurrect/continuum/catppuccin.
6. **Статус-бар** — тема, окна, индикаторы prefix/zoom/sync.
7. **Запуск TPM** — с проверкой наличия.

### Имена окон

Автопереименование включено, но `automatic-rename-format` пустой. Поэтому
обычные окна показываются только индексом (`1`, `2`, ...). Если переименовать
окно вручную (`prefix + ,`), в статус-баре появится `1: имя`.

### Статус-бар

- Тема: Catppuccin Mocha, фон — `#{@thm_bg}` (base).
- Слева: имя сессии; при нажатом префиксе он становится красным.
- Метки `Z` и `SYNC` показывают zoom панели и синхронизацию ввода.
- Справа: дата и время.
- Если нужен прозрачный статус-бар, поставь
  `@catppuccin_status_background 'none'` и убери `status-style` с `bg`.
  Учти, что фон сегментов окон при этом останется непрозрачным.

## Плагины

| Плагин | Зачем |
|---|---|
| `tmux-plugins/tpm` | менеджер плагинов |
| `tmux-plugins/tmux-resurrect` | сохранение и восстановление сессий |
| `tmux-plugins/tmux-continuum` | автосохранение и восстановление при старте |
| `catppuccin/tmux#v2.3.2` | тема и переменные `@thm_*` для статус-бара |

Catppuccin закреплён на `v2.3.2`, чтобы обновление темы не ломало конфиг
неожиданно. Чтобы обновить тему, поменяй тег в `tmux.conf` и выполни
`prefix + U`.

### Почему нет tmux-sensible

`tmux-sensible` добавляет скрытые настройки и биндинги (`R` для reload,
`aggressive-resize`, `status-keys`, `C-p/C-n` и т.п.). На tmux 3.7 полезная
часть сводится к нескольким опциям, которые в этом конфиге заданы явно:
`history-limit`, `focus-events`, `display-time`, `status-interval`,
`status-keys`. Плагин убран, чтобы поведение было предсказуемым.

### Почему нет tmux-sessionist

`tmux-sessionist` добавляет `prefix + g/C/X/S/@` и join-pane, но переопределяет
стандартные `prefix + t` (clock-mode) и `prefix + C` (customize-mode). Встроенные
возможности tmux закрывают основные сценарии: `prefix + s`, `prefix + L`,
`prefix + $`, `prefix + (`, `prefix + )`, `prefix + d`. Вместо sessionist
добавлен только `prefix + X` с подтверждением.

## Copy/paste

- `set-clipboard on` разрешает приложениям (nvim, yazi) использовать OSC 52.
- `y` и копирование мышью отправляют выделение в `wl-copy`.
- На X11 замени `wl-copy` на `xclip -in -selection clipboard`.
- На macOS — на `pbcopy`.
- Если tmux запущен на удалённой машине, `wl-copy` там не сработает: нужен
  либо clipboard-инструмент удалённой системы, либо проброс OSC 52 через
  терминал.

## Восстановление сессий

- `@continuum-save-interval 15` — автосохранение раз в 15 минут.
- `@continuum-restore on` — восстановление при старте tmux.
- `@resurrect-capture-pane-contents off` — сохраняется layout и запущенные
  программы, но **не** содержимое панелей. Это уменьшает риск утечки токенов
  и лишних данных.
- Каталог сохранений: `~/.local/share/tmux/resurrect`.
- Ручное сохранение/восстановление: `prefix + C-s` / `prefix + C-r`.

Если восстановление не нужно, удали `tmux-resurrect` и `tmux-continuum` из
секции плагинов.

## Обслуживание

Обновить плагины:

```text
prefix + U
```

Удалить неиспользуемые плагины:

```text
prefix + M-u
```

Проверить конфиг в отдельном сервере, не трогая текущую сессию:

```bash
tmux -L tmux-check -f ~/.config/tmux/tmux.conf new-session -d
tmux -L tmux-check show-messages
tmux -L tmux-check kill-server
```

Важно: `source-file` не удаляет опции, которых больше нет в конфиге. Если
убрал настройку и хочешь вернуть дефолт, перезапусти сервер:

```bash
tmux kill-server
```

## Troubleshooting

### Нет цветов в статус-баре

Скорее всего, не загружен Catppuccin. Проверь:

```bash
tmux show-options -gv @thm_bg
```

Если выводится `invalid option: @thm_bg`, плагин не установлен или TPM не
запустился. Установи TPM и выполни `prefix + I`.

### При старте сообщение «TPM не найден»

Склонируй TPM в `~/.config/tmux/plugins/tpm` (см. установку выше) или поправь
путь в конце `tmux.conf`.

### Иконки показываются квадратами

Нужен Nerd Font, например `JetBrainsMono Nerd Font`. Проверь настройку шрифта
в Alacritty.

### Не работает копирование

- Убедись, что установлен `wl-clipboard` и задан `WAYLAND_DISPLAY`.
- Проверь, что tmux запущен в той же Wayland-сессии, где доступен `wl-copy`.
- Для SSH настрой OSC 52 в терминале или замени команду копирования.
- Не используй `unbind-key -a -T root`: эта команда удаляет встроенные
  mouse-биндинги, после чего мышь в tmux перестаёт работать.

### После `prefix + r` остались старые настройки

Это нормально для удалённых опций. Перезапусти сервер: `tmux kill-server`.

### Мышь перестала работать

Проверь, что в конфиге нет `unbind-key -a -T root`. В tmux 3.7 в root-таблице
находятся клики по панелям, прокрутка колесом и клики по статус-бару.

## Проверка после изменений

```bash
tmux -L tmux-check -f ~/.config/tmux/tmux.conf new-session -d
tmux -L tmux-check show-options -g history-limit
tmux -L tmux-check show-options -s focus-events
tmux -L tmux-check list-keys -T prefix
tmux -L tmux-check show-messages
tmux -L tmux-check kill-server
```
