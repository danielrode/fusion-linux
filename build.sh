#!/usr/bin/env bash
# Dependencies:
#   Bash 4+
#   Docker 27.1.1 OR Podman 5.1.2
#   Apptainer 1.3.3


CONTAINER_NAME="fusion-linux:latest"


# Decide whether to use Docker or Podman
container_manager=docker
[[ $USE_PODMAN == true ]] && container_manager=podman

# Build Docker container
cd "$(dirname "$0")"
$container_manager build --tag "$CONTAINER_NAME" .

# Convert Docker container to Singularity (Apptainer) image file
cmd=($container_manager
  image inspect
  --format '{{.ID}}'
  "$CONTAINER_NAME"
)
imageID="$("${cmd[@]}" | head -c 12)"
tar_path="./docker-image-${imageID}.tar"
if [[ ! -e "$tar_path" ]]
then
  $container_manager save --output "$tar_path" "$CONTAINER_NAME"
fi
# sif_path="./apptainer-image-${imageID}.sif"
# if [[ ! -e "$sif_path" ]]
# then
#   apptainer build "$sif_path" "docker-archive:${tar_path}"
# fi
