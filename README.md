# FUSION on Linux

Containerized [FUSION](https://research.fs.usda.gov/pnw/products/dataandtools/tools/fusion/ldv-lidar-processing-and-visualization-software-version-4.40) (LiDAR processing software) that runs on Linux via WINE.

## Build Container on Fedora Linux

```sh
sudo dnf install git podman
git clone https://github.com/VogelerLab/fusion-linux
cd fusion-linux
bash ./build.sh
```

## Run Container on Fedora Linux

```sh
sudo dnf install podman remmina
bash ./run.sh fusion &
remmina --connect vnc://localhost:5900
```

Any VNC client should work. Remmina was picked because it is available in Fedora repos and is easy to use.

## Run Container on HPC

This section is IN PROGRESS

```sh
acompile
apptainer docker-archive:PATH_TO_DOCKER_IMAGE.tar fusion
```

TODO Implement way to connect to VNC server on HPC
