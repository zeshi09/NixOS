{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixeshi = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix 
            inputs.nixosModules.nixvim
          ];
          specialArgs = {
            inherit pkgs-unstable;
          };
      };
    };
      homeConfigurations = {
        blackzeshi = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
          };
        };
      };
    };

}
