#!/usr/bin/env bash
# Dependencies:
#   Bash 4+
#   Docker 27.1.1 OR Podman 5.2.3


CONTAINER_NAME="fusion-linux:latest"


# Decide whether to use Docker or Podman
if command -v podman > /dev/null
then
  container_manager=podman
elif command -v docker > /dev/null
then
  container_manager=docker
else
  echo "error: No suitable container manager was found"
  exit 1
fi

# Build container
cd "$(dirname "$0")"
$container_manager build --tag "$CONTAINER_NAME" .
