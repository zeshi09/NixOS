{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      # url = "github:elythh/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixvim, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      nixvim = nixvim.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixeshi = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix 
            # inputs.nixvim.nixosModules.nixvim
          ];
          specialArgs = {
            inherit pkgs-stable;
          };
      };
    };
      # nvim = nixvim.makeNixvimWithModule {
      #   inherit pkgs;
      #   module = ./nixvimconfig;
      # };
      homeConfigurations = {
        blackzeshi = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit pkgs-stable;
          };
        };
      };
    };

}
