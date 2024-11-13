#!/usr/bin/env bash
# Dependencies:
#   Bash 4+
#   Docker 27.1.1 OR Podman 5.2.3 OR Apptainer 1.3.3


CONTAINER_NAME="fusion-linux:latest"
CONTAINER_GIT_URL="ghcr.io/danielrode/fusion-linux:main"
PORT="5900:5900"
DOCKER_OPTS=(
  --publish "$PORT"
  --mount "type=bind,source=$(pwd),target=/portal"
)
APPTAINER_OPTS=(
  --contain
  --cleanenv
  --writable-tmpfs
  # --net --network-args "portmap=$PORT/tcp"  # TODO
  --mount "type=bind,src=$(pwd),dst=/portal"
)


# Parse command line options
if [[ $1 == --debug ]]
then
  shift
  DOCKER_OPTS+=( --interactive --tty --entrypoint /bin/sh )
fi

# Determine which container manager to use
if command -v docker > /dev/null
then
  container_check_cmd=(docker image inspect "$CONTAINER_NAME")
  container_pull_cmd=(docker pull)
  container_tag_cmd=(docker image tag "$CONTAINER_GIT_URL" "$CONTAINER_NAME")
  container_run_cmd=(docker run "${DOCKER_OPTS[@]}" "$CONTAINER_NAME")
elif command -v podman > /dev/null
then
  container_check_cmd=(podman image inspect "$CONTAINER_NAME")
  container_pull_cmd=(podman pull)
  container_tag_cmd=(podman image tag "$CONTAINER_GIT_URL" "$CONTAINER_NAME")
  container_run_cmd=(podman run "${DOCKER_OPTS[@]}" "$CONTAINER_NAME")
elif command -v apptainer > /dev/null
then
  sif_name=fusion-linux-main.sif
  container_check_cmd=(test -e "$sif_name")
  container_pull_cmd=(apptainer pull
    "$container_name"
    "docker://$CONTAINER_GIT_URL"
  )
  container_tag_cmd=(:)  # Do nothing
  container_run_cmd=(apptainer run "${APPTAINER_OPTS[@]}" "$sif_name")
else
  echo "error: No suitable container manager was found"
  exit 1
fi

# Retrieve container image, if necessary
if ! "${container_check_cmd[@]}" &> /dev/null
then
  "${container_pull_cmd}" "$CONTAINER_GIT_URL"
  "${container_tag_cmd}"
fi

# Run container
"${container_run_cmd[@]}" "$@"
