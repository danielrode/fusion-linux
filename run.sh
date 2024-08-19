#!/usr/bin/env bash
# Dependencies:
#   Bash 4+
#   Docker 27.1.1 OR Podman 5.1.2 OR Apptainer 1.3.3


CONTAINER_NAME="fusion-linux:latest"
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
  docker_image_path="$1"
  shift
  apptainer exec "${APPTAINER_OPTS[@]}" "$docker_image_path" "$@"
else
  container_manager=docker
  [[ $USE_PODMAN == true ]] && container_manager=podman
  $container_manager run "${DOCKER_OPTS[@]}" "$CONTAINER_NAME" "$@"
fi
