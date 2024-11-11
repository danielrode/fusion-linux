#!/usr/bin/env bash
# Dependencies:
#   Bash 4+
#   Docker 27.1.1 OR Podman 5.2.3 OR Apptainer 1.3.3


CONTAINER_NAME="fusion-linux:latest"
# TODO run command to pull container image first from github and then tag it
# fusion-linux:latest, then call the container by that name to start it.
CONTAINER_NAME="ghcr.io/danielrode/fusion-linux:main"
PORT="5900:5900"
DOCKER_OPTS=(
  --publish $PORT
  --mount "type=bind,source=$(pwd),target=/portal"
)
APPTAINER_OPTS=(
  --contain
  --cleanenv
  --writable-tmpfs
  # --net --network-args "portmap=$PORT/tcp"  # TODO
  --mount "type=bind,src=$(pwd),dst=/portal"
)


if [[ $1 == --debug ]]
then
  shift
  DOCKER_OPTS+=( --interactive --tty --entrypoint /bin/sh )
fi

if [[ -n $SLURM_JOB_ID ]]
then
  apptainer exec "${APPTAINER_OPTS[@]}" "$CONTAINER_NAME" "$@"
else
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
  $container_manager run "${DOCKER_OPTS[@]}" "$CONTAINER_NAME" "$@"
fi
