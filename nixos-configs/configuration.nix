{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/all-modules.nix 
  ];

  # disabledModules = [];
  hardware.graphics.enable32Bit = true;
  time.timeZone = "Europe/Minsk";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
