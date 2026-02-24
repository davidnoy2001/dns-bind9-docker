#!/usr/bin/env bash
set -euo pipefail
# scripts/up.sh - Build and run the docker-compose environment with optional APT proxy
# Usage:
#   ./scripts/up.sh           # interactive foreground
#   ./scripts/up.sh --detach  # run detached

APT_PROXY="${APT_PROXY:-${DOCKER_APT_PROXY:-}}"

BUILD_ARGS=()
if [ -n "$APT_PROXY" ]; then
  echo "Detected APT proxy: $APT_PROXY"
  BUILD_ARGS+=(--build-arg "APT_PROXY=$APT_PROXY")
else
  echo "No APT proxy detected. Building without APT proxy build-arg."
fi

echo "Running: docker compose build ${BUILD_ARGS[*]}"
docker compose build "${BUILD_ARGS[@]}"

if [ "${1:-}" = "--detach" ] || [ "${1:-}" = "-d" ]; then
  echo "Starting containers in detached mode..."
  docker compose up --build -d
else
  echo "Starting containers (foreground)..."
  docker compose up --build
fi
