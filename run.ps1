# Dependencies:
#   Windows 11
#   PowerShell 5+
#   WSL 2
#   Podman 5.2.4


$CONTAINER_NAME = "fusion-linux:latest"
$PORT = "5900:5900"
$DOCKER_OPTS = @(
  "--publish", $PORT
  "--mount", "type=bind,source=$(pwd),target=/portal"
)


# Make sure container machine backend is setup and running
podman machine init
podman machine start

# Retrieve container image, if necessary
podman image inspect fusion-linux:latest *> $null
if (-not $?) {
    podman pull ghcr.io/danielrode/fusion-linux:main
    podman image tag ghcr.io/danielrode/fusion-linux:main $CONTAINER_NAME
}

# Run container
podman run @DOCKER_OPTS fusion-linux:latest @args
