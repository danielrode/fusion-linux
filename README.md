# FUSION on Linux

Containerized
[FUSION](https://research.fs.usda.gov/pnw/products/dataandtools/tools/fusion/ldv-lidar-processing-and-visualization-software-version-4.40)
(LiDAR processing software) that runs on Linux via WINE.

## Run Container on Windows 11

1. Open cmd.exe prompt
2. `winget install -e --id RedHat.Podman`
3. Approve admin privileges request and finish install wizard
4. Close cmd.exe prompt window and then open a new cmd.exe prompt
(this is necessary to recognize the new install)
5. `podman machine init`
6. `podman machine start`
7. `podman run ghcr.io/danielrode/fusion-linux:main`

## Run Container on Fedora Linux

```sh
sudo dnf install podman remmina
podman run ghcr.io/danielrode/fusion-linux:main
remmina --connect vnc://localhost:5900
```

Any VNC client should work. Remmina was picked because it is available in
Fedora repos and is easy to use.

## Run Container on HPC

```sh
acompile
apptainer run docker://ghcr.io/danielrode/fusion-linux:main
```

TODO Implement way to connect to VNC server on HPC

## Building Container

GitHub builds this container automatically, but if you would like to build it
yourself, see `build.sh`.
