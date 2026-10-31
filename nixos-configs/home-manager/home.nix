{ config, pkgs, ... }: {

  imports = [
    ./modules/all-modules.nix
  ];

  home = {
    username = "ifmund";
    homeDirectory = "/home/ifmund";
    stateVersion = "26.05";

    packages = with pkgs; [ cowsay ];
  };

  programs.home-manager.enable = true;
}
