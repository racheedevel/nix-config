{
  description = "{{PROJECT_NAME}} - Go API with Chi";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "{{PROJECT_NAME}}";
          version = "0.1.0";
          src = ./.;
          vendorHash = null;  # Update after go mod tidy
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go
            gopls
            golangci-lint
            delve
            air  # Hot reload
          ];
          
          shellHook = ''
            export GOPATH="$PWD/.go"
            export PATH="$GOPATH/bin:$PATH"
            echo "🐹 {{PROJECT_NAME}} Go dev environment"
            echo "   Run: go run . or air"
          '';
        };
      }
    );
}
