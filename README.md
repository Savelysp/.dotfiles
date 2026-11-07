# Dotfiles

Личная конфигурация **NixOS** и рабочего окружения на **Wayland** (niri).

Репозиторий объединяет две вещи:

- **Система** — декларативная конфигурация NixOS через flakes и Home Manager
  (`.nixos-configs/`).
- **Пользовательские конфиги** — dotfiles для приложений, раскладываемые по
  домашнему каталогу через **GNU Stow** (`.config/`, `.zshrc` и т. д.).

## Стек

| Уровень                        | Технологии                                                   |
|--------------------------------|--------------------------------------------------------------|
| ОС                             | NixOS 26.05, flakes, Home Manager                            |
| Композитор                     | niri, xwayland-satellite                                     |
| Панель / лаунчер / уведомления | waybar, fuzzel, mako, awww                                   |
| Терминал и shell               | Alacritty, zsh, starship, zoxide, eza, bat, fzf, ripgrep     |
| Мультиплексоры                 | tmux, zellij                                                 |
| Редакторы                      | Neovim (lazy.nvim), GNU Emacs (org-tangle), Vim              |
| Файловый менеджер              | yazi                                                         |
| Разработка                     | Python (`uv`, `ruff`, `pyright`), Rust, GCC, Node.js, Docker |

## Структура репозитория

```text
.
├── .config/
│   ├── alacritty/        Alacritty: конфиг и темы
│   ├── emacs/            config.org — единственный исходник Emacs-конфига
│   ├── niri/             config.kdl — настройки композитора niri
│   ├── nvim/             Neovim на lazy.nvim
│   ├── tmux/             tmux.conf + README с клавишами
│   ├── waybar/           панель: config.jsonc, style.css
│   ├── yazi/             файловый менеджер
│   └── starship.toml     промпт
├── .nixos-configs/
│   ├── flake.nix         входные данные и nixosConfigurations
│   ├── configuration.nix точка входа системы
│   ├── packages.nix      системные пакеты и шрифты
│   ├── hardware-configuration.nix
│   ├── modules/          модули NixOS (niri, звук, docker, ssh, keyd…)
│   └── home-manager/     Home Manager и его модули
├── .zshrc                конфигурация zsh
├── .vimrc                минимальный vimrc
└── .stow-local-ignore    что Stow не трогает
```

## Установка

### 1. Система (NixOS)

Всё описано в `.nixos-configs/flake.nix`; хост называется `nixos`, пользователь —
`ifmund`.

```bash
# первый запуск или обычное обновление
sudo nixos-rebuild switch --flake ~/.dotfiles/.nixos-configs#nixos
```

В `.zshrc` для этого есть алиас:

```bash
nixreb   # sudo nixos-rebuild switch --flake /home/ifmund/.nixos-configs
```

> Перед первым применением на другой машине замените
> `hardware-configuration.nix` на сгенерированный для своего железа.

### 2. Dotfiles (GNU Stow)

Stow создаёт симлинки из репозитория в `$HOME`. Запускать нужно из корня
репозитория:

```bash
cd ~/.dotfiles
stow --target="$HOME" .
```

Проверить, что будет сделано, без изменений:

```bash
stow --simulate --verbose --target="$HOME" .
```

Удалить симлинки:

```bash
stow -D --target="$HOME" .
```

Каталоги и файлы из `.stow-local-ignore` (`.git`, `.gitignore`, `org_files`,
`suckless`, `*.org`) не раскладываются. Часть конфигов дополнительно исключена
через `.gitignore` — они либо генерируются, либо содержат состояние приложений.

## Компоненты

### NixOS

- `configuration.nix` — точка входа: hardware, пакеты, модули, таймзона
  `Europe/Minsk`, включённые flakes.
- `packages.nix` — системные пакеты, `allowUnfree`, шрифты Nerd Fonts
  (JetBrains Mono, Symbols, Font Awesome).
- `modules/` — по модулю на тему: загрузчик (systemd-boot), сеть
  (NetworkManager), звук (PipeWire), Bluetooth, тачпад, Docker, SSH, swapfile
  16 ГиБ, keyd (`CapsLock` → `Esc`), udisks2, niri.
- `home-manager/` — пользовательская часть: `ifmund`, `stateVersion`, пакеты и
  сервисы (например, `udiskie` с автомонтированием).

### Neovim

Конфигурация на [lazy.nvim](https://github.com/folke/lazy.nvim). Точка входа —
`init.lua`, порядок загрузки: `options` → `lazy` → `keymaps`.

- `lua/config/` — опции, загрузчик плагинов, маппинги.
- `lua/plugins/` — по файлу на плагин: telescope, nvim-tree, cmp, luasnip,
  treesitter, lspconfig + mason, gitsigns, bufferline, lualine, toggleterm,
  dashboard, which-key, todo-comments, colorizer и др.
- `lua/util/palette.lua` — общие цвета для тем.

Лидер-клавиша — `Space`. Полезное:

| Клавиша | Действие |
| --- | --- |
| `<C-s>` | сохранить файл |
| `<C-n>` | открыть/закрыть дерево файлов |
| `<leader>t` | фокус на дереве файлов |
| `<leader>/` | закомментировать строку/выделение |
| `<leader>nh` | убрать подсветку поиска |
| `<C-h/j/k/l>` | переключение окон |
| `jk` | выход из Insert |

### Emacs

Единственный исходник — `.config/emacs/config.org`. Из него при старте
танглятся `config.el` и `init.el`; сгенерированные файлы и состояние (`elpa/`,
`eln-cache/`, `var/`, `org-roam.db` и т. п.) в git не попадают.

В конфиге: Evil mode, Vertico/Orderless/Marginalia/Consult/Embark, Corfu,
Org mode + Org Roam, Doom themes/modeline, Dired, Magit и др.

### tmux

Подробное описание, требования и клавиши — в
[`.config/tmux/README.md`](./.config/tmux/README.md). Кратко: префикс `C-b`,
перезагрузка конфига `prefix + r`, плагины через TPM.

### zsh

- `starship` и `zoxide` инициализируются в `.zshrc`.
- История: 10 000 строк, общая между сессиями, без дубликатов.
- Vi-режим ввода, автодополнение с меню, `AUTO_CD`, `GLOB_DOTS`.
- Плагины `zsh-autosuggestions` и `zsh-syntax-highlighting` ожидаются в
  `~/.zsh-plugins/`.

Полезные алиасы:

| Алиас | Команда |
| --- | --- |
| `ls` | `eza --icons=always` |
| `cat` | `bat` |
| `n` | `nvim` |
| `nixreb` | пересборка NixOS из флейка |
| `..`, `...`, `....` | подъём по каталогам |

### Оформление

- **Alacritty** — тема `monokai_pro`, прозрачность 0.95, JetBrains Mono 16,
  отступы 5 px. Другие темы лежат в `.config/alacritty/themes/`.
- **waybar** — workspace'ы и окно niri, раскладка, батарея, яркость, звук,
  сеть, часы, трей и меню питания.
- **niri** — раскладки `us,ru` с `Alt+Shift`, тачпад с tap и natural-scroll,
  масштаб `1.25` для `eDP-1`.
- **starship** — компактный промпт: каталог, git-ветка, Python, символ.

## Требования

- NixOS с включёнными flakes (или установленный `nix` + `home-manager`).
- `stow` для раскладки dotfiles.
- Nerd Font (JetBrains Mono Nerd Font) — иконки в waybar, nvim, tmux.
- `wl-clipboard` — буфер обмена на Wayland.
- Плагины zsh в `~/.zsh-plugins/` и TPM в `~/.config/tmux/plugins/`
  (ставятся отдельно, см. соответствующие README).

## Заметки

- Конфиги, содержащие машинно-специфичное состояние или кэш (Obsidian,
  opencode, dconf, pulse, systemd/user, spotify, btop и др.), намеренно
  исключены через `.gitignore`.
- **Не редактируйте** сгенерированные Emacs-файлы (`*.el`) — правки нужно
  вносить в `config.org` и танлеить заново.
