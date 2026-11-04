{ pkgs, inputs, ... }: {

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = (with pkgs; [
    # Text Editors
    vim     # Base editor
    neovim  # Better vim
    emacs   # Best editor

    # Wayland
    fuzzel
    awww
    waybar
    mako
    wl-clipboard
    xwayland-satellite

    # AI
    llama-cpp-rocm

    # Desktop
    telegram-desktop
    steam 
    discord
    spotify
    mpv
    zathura
    obsidian

    # CLI 
    btop    # Better top
    neohtop
    bottom
    zoxide  # Better cd
    bat     # Better cat
    eza     # Better ls
    fd      # Better find
    ripgrep # Better grep
    fzf     # Fuzzy finder
    stow    # Dotfiles manager
    brightnessctl  # Brightness control
    cloc
    blobdrop
    speedread
    ggh
    tabiew

    # Useless CLI
    fastfetch  # Best fetch
    cbonsai
    lavat
    pipes-rs
    cmatrix
    mapscii
    tty-clock
    globe-cli
    cava

    # Network
    wget    # Downoader
    curl    # Browser

    # Develop
    git
    lazygit
    docker
    docker-compose
    lazydocker

    # File manager
    yazi

    # Code
    gcc
    tree-sitter
    python314
    python314Packages.pip
    nodejs
   
    # Term
    tmux
    zellij
    alacritty  # Terminal emulator
    ueberzugpp # Image support
    starship   # Shell prompt
  ]) ++ [
    inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.opencode
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    font-awesome
  ];
}
