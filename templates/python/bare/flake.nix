{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python314;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            python
            pkgs.uv
          ];

          env = {
            UV_PYTHON = "${python}/bin/python";
            UV_PYTHON_PREFERENCE = "only-system";
          };

          shellHook = ''
            [[ -d .venv ]] || uv venv
            source .venv/bin/activate
            uv sync 2>/dev/null || true
          '';
        };
      }
    );
}
