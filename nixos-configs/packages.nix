{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Text Editors
    vim     # Base editor
    neovim  # Better vim
    emacs   # Best editor

    # Wayland
    fuzzel
    awww
    waybar
    wl-clipboard
    xwayland-satellite

    # AI
    opencode
    # openclaw

    # Desktop
    telegram-desktop
    steam 
    discord
    spotify
    mpv
    zathura

    # CLI 
    btop    # Better top
    zoxide  # Better cd
    bat     # Better cat
    eza     # Better ls
    fd      # Better find
    ripgrep # Better grep
    fzf     # Fuzzy finder
    stow    # Dotfiles manager
    brightnessctl  # Brightness control

    # Useless CLI
    fastfetch  # Best fetch

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
    alacritty  # Terminal emulator
    ueberzugpp # Image support
    starship   # Shell prompt
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    font-awesome
  ];
}
