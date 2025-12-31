{
  rust = ''
    stages:
      - check
      - test
      - build

    variables:
      CARGO_HOME: $CI_PROJECT_DIR/.cargo

    cache:
      key: $CI_COMMIT_REF_SLUG
      paths:
        - .cargo/
        - target/

    check:
      stage: check
      image: rust:latest
      script:
        - cargo fmt --check
        - cargo clippy -- -D warnings

    test:
      stage: test
      image: rust:latest
      script:
        - cargo test

    build:
      stage: build
      image: rust:latest
      script:
        - cargo build --release
      artifacts:
        paths:
          - target/release/{{PROJECT_NAME}}
  '';

  python = ''
    stages:
      - lint
      - test
      - build

    variables:
      UV_CACHE_DIR: $CI_PROJECT_DIR/.uv-cache

    cache:
      key: $CI_COMMIT_REF_SLUG
      paths:
        - .uv-cache/
        - .venv/

    lint:
      stage: lint
      image: ghcr.io/astral-sh/uv:latest
      script:
        - uv sync --dev
        - uv run ruff check .
        - uv run ruff format --check .

    test:
      stage: test
      image: ghcr.io/astral-sh/uv:latest
      script:
        - uv sync --dev
        - uv run pytest

    build:
      stage: build
      image: ghcr.io/astral-sh/uv:latest
      script:
        - uv build
      artifacts:
        paths:
          - dist/
  '';

  go = ''
    stages:
      - lint
      - test
      - build

    variables:
      GOPATH: $CI_PROJECT_DIR/.go

    cache:
      key: $CI_COMMIT_REF_SLUG
      paths:
        - .go/

    lint:
      stage: lint
      image: golangci/golangci-lint:latest
      script:
        - golangci-lint run

    test:
      stage: test
      image: golang:latest
      script:
        - go test -v ./...

    build:
      stage: build
      image: golang:latest
      script:
        - CGO_ENABLED=0 go build -o {{PROJECT_NAME}} .
      artifacts:
        paths:
          - {{PROJECT_NAME}}
  '';

  typescript = ''
    stages:
      - lint
      - test
      - build

    cache:
      key: $CI_COMMIT_REF_SLUG
      paths:
        - node_modules/

    lint:
      stage: lint
      image: oven/bun:latest
      script:
        - bun install
        - bun run lint

    test:
      stage: test
      image: oven/bun:latest
      script:
        - bun install
        - bun test

    build:
      stage: build
      image: oven/bun:latest
      script:
        - bun install
        - bun run build
      artifacts:
        paths:
          - dist/
  '';
}
