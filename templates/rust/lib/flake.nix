{
  description = "{{PROJECT_NAME}} - Rust application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, crane, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ rust-overlay.overlays.default ];
        pkgs = import nixpkgs { inherit system overlays; };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
        };
        
        craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;
        
        src = craneLib.cleanCargoSource ./.;
        
        commonArgs = {
          inherit src;
          strictDeps = true;
        };
        
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        
        {{PROJECT_NAME_SNAKE}} = craneLib.buildPackage (commonArgs // {
          inherit cargoArtifacts;
        });
      in
      {
        checks = {
          inherit {{PROJECT_NAME_SNAKE}};
          
          clippy = craneLib.cargoClippy (commonArgs // {
            inherit cargoArtifacts;
            cargoClippyExtraArgs = "--all-targets -- --deny warnings";
          });
          
          fmt = craneLib.cargoFmt { inherit src; };
          
          test = craneLib.cargoTest (commonArgs // {
            inherit cargoArtifacts;
          });
        };

        packages = {
          default = {{PROJECT_NAME_SNAKE}};
          
          docker = pkgs.dockerTools.buildLayeredImage {
            name = "{{PROJECT_NAME}}";
            tag = "latest";
            contents = [ {{PROJECT_NAME_SNAKE}} pkgs.cacert ];
            config = {
              Cmd = [ "${{{PROJECT_NAME_SNAKE}}}/bin/{{PROJECT_NAME}}" ];
            };
          };
        };

        devShells.default = craneLib.devShell {
          checks = self.checks.${system};
          
          packages = with pkgs; [
            rust-analyzer
            cargo-watch
            cargo-edit
            cargo-expand
            cargo-audit
          ];
          
          shellHook = ''
            echo "🦀 {{PROJECT_NAME}} dev environment"
          '';
        };
      }
    );
}
