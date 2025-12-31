# {{PROJECT_NAME}}

Created on {{DATE}}.

## Development
```bash
# Enter dev shell (automatic with direnv)
nix develop

# Build
cargo build

# Run
cargo run

# Test
cargo test

# Watch mode
cargo watch -x run
```

## Build
```bash
# Nix build
nix build

# Docker image
nix build .#docker
docker load < result
```
