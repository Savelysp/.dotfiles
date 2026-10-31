{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/all-modules.nix 
  ];

  disabledModules = [ ./modules/hyperland.nix ];

  time.timeZone = "Europe/Minsk";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
