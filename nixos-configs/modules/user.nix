{ pkgs, ... }: {
  
  programs.zsh.enable = true;

  users.users.ifmund = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };
}
