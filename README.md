# FUSION on Linux

Containerized
[FUSION](https://research.fs.usda.gov/pnw/products/dataandtools/tools/fusion/ldv-lidar-processing-and-visualization-software-version-4.40)
(LiDAR processing software) that runs on Linux via WINE.

## Run Container on Fedora Linux

```sh
sudo dnf install podman remmina
docker run ghcr.io/VogelerLab/fusion-linux:main
remmina --connect vnc://localhost:5900
```

Any VNC client should work. Remmina was picked because it is available in
Fedora repos and is easy to use.

## Run Container on HPC

```sh
acompile
apptainer run docker://ghcr.io/vogelerlab/fusion-linux:main
```

TODO Implement way to connect to VNC server on HPC

## Building Container

GitHub builds this container automatically, but if you would like to build it
yourself, see `build.sh`.
