{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "mkproject" ''
      set -euo pipefail

      # ─────────────────────────────────────────────
      # Configuration
      # ─────────────────────────────────────────────
      TEMPLATES_DIR="$HOME/.os/templates"

      # Colors
      RED='\033[0;31m'
      GREEN='\033[0;32m'
      YELLOW='\033[1;33m'
      BLUE='\033[0;34m'
      NC='\033[0m'

      log() { echo -e "''${GREEN}[mkproject]''${NC} $*"; }
      warn() { echo -e "''${YELLOW}[mkproject]''${NC} $*"; }
      err() { echo -e "''${RED}[mkproject]''${NC} $*" >&2; }

      # ─────────────────────────────────────────────
      # Help
      # ─────────────────────────────────────────────
      usage() {
        cat <<EOF
      Usage: mkproject <language>/<template> <name> [options]

      Languages and templates:
        rust/default      Basic Rust binary
        rust/lib          Rust library (publishable)
        rust/workspace    Cargo workspace

        python/lib      Python library (uv)
        python/bin      Python CLI app (uv)
        python/api      FastAPI application
        python/ws       Python workspace
        python/nb       Marimo notebook environment
        python/notebook Marimo notebook environment

        ts/bunreact       React app with Bun
        ts/bunlib         Bun library (publishable)
        ts/tanstack       TanStack Router + Query
        ts/solidjs        SolidJS with Bun

        go/api            Go API with Chi
        go/binary         Go CLI with Cobra
        go/service        Go background service

      Options:
        -d, --dir <path>    Parent directory (default: current)
        -g, --git-remote    Git remote URL
        -r, --registry      Package registry URL (Python)
        -p, --postgres      Include Postgres for testing
        --no-git            Don't initialize git
        --no-install        Don't install dependencies
        -h, --help          Show this help

      Examples:
        mkproject rust/default my-cli
        mkproject python/api my-api --postgres
        mkproject ts/bunreact frontend -d /hub/myorg
        mkproject go/api backend --git-remote git@gitlab.com:org/backend.git
      EOF
        exit 0
      }

      # ─────────────────────────────────────────────
      # Argument parsing
      # ─────────────────────────────────────────────
      TEMPLATE=""
      PROJECT_NAME=""
      PARENT_DIR="."
      GIT_REMOTE=""
      REGISTRY=""
      WITH_POSTGRES=false
      NO_GIT=false
      NO_INSTALL=false

      while [[ $# -gt 0 ]]; do
        case "$1" in
          -h|--help) usage ;;
          -d|--dir) PARENT_DIR="$2"; shift 2 ;;
          -g|--git-remote) GIT_REMOTE="$2"; shift 2 ;;
          -r|--registry) REGISTRY="$2"; shift 2 ;;
          -p|--postgres) WITH_POSTGRES=true; shift ;;
          --no-git) NO_GIT=true; shift ;;
          --no-install) NO_INSTALL=true; shift ;;
          -*)
            err "Unknown option: $1"
            exit 1
            ;;
          *)
            if [[ -z "$TEMPLATE" ]]; then
              TEMPLATE="$1"
            elif [[ -z "$PROJECT_NAME" ]]; then
              PROJECT_NAME="$1"
            else
              err "Unexpected argument: $1"
              exit 1
            fi
            shift
            ;;
        esac
      done

      if [[ -z "$TEMPLATE" ]] || [[ -z "$PROJECT_NAME" ]]; then
        err "Missing required arguments"
        usage
      fi

      # Parse language/template
      LANG="''${TEMPLATE%%/*}"
      TMPL="''${TEMPLATE##*/}"
      TEMPLATE_PATH="$TEMPLATES_DIR/$LANG/$TMPL"

      if [[ ! -d "$TEMPLATE_PATH" ]]; then
        err "Template not found: $TEMPLATE_PATH"
        echo "Available templates:"
        find "$TEMPLATES_DIR" -mindepth 2 -maxdepth 2 -type d | sed "s|$TEMPLATES_DIR/||" | sort
        exit 1
      fi

      # ─────────────────────────────────────────────
      # Project setup
      # ─────────────────────────────────────────────
      PROJECT_DIR="$PARENT_DIR/$PROJECT_NAME"

      if [[ -e "$PROJECT_DIR" ]]; then
        err "Directory already exists: $PROJECT_DIR"
        exit 1
      fi

      log "Creating project: $PROJECT_NAME ($TEMPLATE)"
      mkdir -p "$PROJECT_DIR"
      cd "$PROJECT_DIR"

      # Copy template files
      log "Copying template..."
      cp -r "$TEMPLATE_PATH/." .

      # ─────────────────────────────────────────────
      # Substitutions
      # ─────────────────────────────────────────────
      log "Applying substitutions..."

      # Common substitutions
      YEAR=$(date +%Y)
      DATE=$(date +%Y-%m-%d)
      PROJECT_NAME_SNAKE=$(echo "$PROJECT_NAME" | tr '-' '_')
      PROJECT_NAME_PASCAL=$(echo "$PROJECT_NAME" | sed -r 's/(^|-)(\w)/\U\2/g')

      # Find and replace in all text files
      find . -type f \( -name "*.nix" -o -name "*.toml" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.md" -o -name "*.rs" -o -name "*.py" -o -name "*.go" -o -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "Dockerfile" -o -name ".gitlab-ci.yml" -o -name ".envrc" \) -exec sed -i \
        -e "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" \
        -e "s|{{PROJECT_NAME_SNAKE}}|$PROJECT_NAME_SNAKE|g" \
        -e "s|{{PROJECT_NAME_PASCAL}}|$PROJECT_NAME_PASCAL|g" \
        -e "s|{{YEAR}}|$YEAR|g" \
        -e "s|{{DATE}}|$DATE|g" \
        {} \;

      # Optional postgres setup
      if [[ "$WITH_POSTGRES" == "true" ]] && [[ -f ".postgres.nix.tmpl" ]]; then
        log "Adding Postgres configuration..."
        mv .postgres.nix.tmpl postgres.nix
        # Merge into flake.nix or docker-compose
      else
        rm -f .postgres.nix.tmpl 2>/dev/null || true
      fi

      # Registry substitution (Python)
      if [[ -n "$REGISTRY" ]] && [[ -f "pyproject.toml" ]]; then
        log "Configuring registry: $REGISTRY"
        cat >> pyproject.toml <<EOF

      [[tool.uv.index]]
      url = "$REGISTRY"
      EOF
      fi

      # ─────────────────────────────────────────────
      # Language-specific initialization
      # ─────────────────────────────────────────────
      if [[ "$NO_INSTALL" != "true" ]]; then
        log "Running language-specific setup..."
        
        case "$LANG" in
          rust)
            # Cargo init if no Cargo.toml exists yet
            if [[ ! -f "Cargo.toml" ]]; then
              if [[ "$TMPL" == "lib" ]]; then
                cargo init --lib --name "$PROJECT_NAME"
              else
                cargo init --name "$PROJECT_NAME"
              fi
            fi
            log "Updating dependencies..."
            cargo update 2>/dev/null || true
            ;;
            
          python)
            case "$TMPL" in
              lib)
                uv init --lib --name "$PROJECT_NAME"
                ;;
              bin|api)
                uv init --app --name "$PROJECT_NAME"
                ;;
              ws)
                uv init --name "$PROJECT_NAME"
                mkdir -p pkg
                ;;
              nb|notebook)
                uv init --app --name "$PROJECT_NAME"
                ;;
            esac
            
            # Install deps from pyproject.toml if they exist
            if [[ -f "pyproject.toml" ]] && grep -q "dependencies" pyproject.toml; then
              log "Installing Python dependencies..."
              uv sync
            fi
            ;;
            
          ts)
            log "Initializing Bun project..."
            bun init -y 2>/dev/null || true
            
            if [[ -f "package.json.tmpl" ]]; then
              # Merge template package.json with bun's
              mv package.json.tmpl package.json
            fi
            
            log "Installing dependencies..."
            bun install
            ;;
            
          go)
            log "Initializing Go module..."
            go mod init "$PROJECT_NAME"
            
            # Install deps if go.mod.tmpl had dependencies
            if grep -q "require" go.mod 2>/dev/null; then
              log "Downloading Go dependencies..."
              go mod tidy
            fi
            ;;
        esac
      fi

      # ─────────────────────────────────────────────
      # Git initialization
      # ─────────────────────────────────────────────
      if [[ "$NO_GIT" != "true" ]]; then
        log "Initializing git..."
        git init -q
        
        if [[ -n "$GIT_REMOTE" ]]; then
          git remote add origin "$GIT_REMOTE"
          log "Added remote: $GIT_REMOTE"
        fi
        
        # Initial commit
        git add .
        git commit -q -m "Initial commit from template: $TEMPLATE"
      fi

      # ─────────────────────────────────────────────
      # direnv setup
      # ─────────────────────────────────────────────
      if [[ -f ".envrc" ]]; then
        log "Allowing direnv..."
        direnv allow . 2>/dev/null || true
      fi

      # ─────────────────────────────────────────────
      # Done
      # ─────────────────────────────────────────────
      echo ""
      log "✓ Project created: $PROJECT_DIR"
      echo ""
      echo -e "  ''${BLUE}cd $PROJECT_DIR''${NC}"
      echo ""

      # Show next steps based on template
      case "$LANG/$TMPL" in
        rust/*)
          echo "  cargo build"
          echo "  cargo run"
          ;;
        python/api)
          echo "  uv run fastapi dev"
          ;;
        python/notebook)
          echo "  uv run marimo edit"
          ;;
        python/*)
          echo "  uv run python -m $PROJECT_NAME_SNAKE"
          ;;
        ts/*)
          echo "  bun dev"
          ;;
        go/*)
          echo "  go run ."
          ;;
      esac
    '')
  ];
}
