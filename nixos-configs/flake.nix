{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix 
	home-manager.nixosModules.home-manager
	{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.ifmund = import ./home-manager/home.nix;
	}
      ];
    };

    # homeConfigurations.ifmund = home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages."x86_64-linux";
    #   modules = [ ./home-manager/home.nix ];
    # };
  };
}
