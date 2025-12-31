{
  description = "rachee nixflake setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      neovim-nightly-overlay,
      zen-browser,
      ...
    }@inputs:
    {
      nixosConfigurations.rachee-fw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/framework/configuration.nix
          ./hosts/framework/system-packages.nix

          { nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rachee = import ./modules/home;
          }
        ];
      };

      templates = {
        rust = {
          path = ./templates/rust/bin;
          description = "Rust binary project with Crane";
        };

        rust-lib = {
          path = ./templates/rust/lib;
          description = "Rust library project";
        };

        rust-ws = {
          path = ./templates/rust/ws;
          description = "Rust workspace";
        };


        python = {
          path = ./templates/python/bare;
          description = "Python env with UV";
        };

        pylib = {
          path = ./templates/python/lib;
          description = "Python library";
        };

        pyapi = {
          path = ./templates/python/api;
          description = "FastAPI App";
        };

        pynb = {
          path = ./templates/python/notebook;
          description = "Marimo env";
        };


        go-api = {
          path = ./templates/go/api;
          description = "Chi API";
        };

        go-bin = {
          path = ./templates/go/bin;
          description = "Go Binary";
        };

        golang = {
          path = ./templates/go/bare;
          description = "Basic go env";
        };
      }
    };
}
