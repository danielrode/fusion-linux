# Dependencies:
#   Windows 11
#   PowerShell 5+


# Install Podman
winget install -e --id RedHat.Podman

# NOTE: Approve admin privileges GUI prompt and finish install wizard

# Refresh PATH variable (so `podman` command works)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

# Retrieve container image, if necessary
podman image inspect fusion-linux:latest *> /dev/null
if (-not $?) {
    podman pull ghcr.io/danielrode/fusion-linux:main
    podman image tag ghcr.io/danielrode/fusion-linux:main fusion-linux:latest
}

# Run container
podman machine init
podman machine start
podman run fusion-linux:latest @args
