{
  description = "{{PROJECT_NAME}} - FastAPI application";

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
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Python + uv
            python314
            uv
            
            # LSPs
            ruff
            pyright
            
            # Tools
            just
            
            # For native deps
            stdenv.cc
          ];
          
          shellHook = ''
            # Create venv if not exists
            [[ -d .venv ]] || uv venv
            source .venv/bin/activate
            
            # Install deps
            uv sync 2>/dev/null || true
            
            echo "🐍 {{PROJECT_NAME}} dev environment"
            echo "   Run: uv run fastapi dev"
          '';
          
          # For packages with native extensions
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc
          ];
        };
        
        # Docker image built from Nix
        packages.docker = pkgs.dockerTools.buildLayeredImage {
          name = "{{PROJECT_NAME}}";
          tag = "latest";
          contents = [
            pkgs.python312
            pkgs.cacert
          ];
          config = {
            Cmd = [ "python" "-m" "uvicorn" "{{PROJECT_NAME_SNAKE}}.main:app" "--host" "0.0.0.0" ];
            ExposedPorts = { "8000/tcp" = {}; };
            WorkingDir = "/app";
          };
        };
      }
    );
}
