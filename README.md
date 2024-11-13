# FUSION on Linux

Containerized
[FUSION](https://research.fs.usda.gov/pnw/products/dataandtools/tools/fusion/ldv-lidar-processing-and-visualization-software-version-4.40)
(LiDAR processing software) that runs on Linux via WINE.

## Run Container on Fedora Linux

```sh
# Bash

sudo dnf install git podman remmina
git clone https://github.com/danielrode/fusion-linux
./fusion-linux/run.sh fusion &
remmina --connect vnc://localhost:5900
```

Any VNC client should work. Remmina was picked because it is available in
Fedora repos and is easy to use.

## Run Container on HPC

TODO This section is incomplete.

```sh
# Bash

acompile
module load git
module load singularity
git clone https://github.com/danielrode/fusion-linux
./fusion-linux/run.sh fusion &
```

TODO Implement way to connect to VNC server on HPC

## Run Container on Windows 11

While FUSION runs natively on Windows, this containerized version can run on
Windows too. It may be useful when reproducibility is important.

```powershell
# PowerShell

winget install -e --id Git.Git
# Complete install via GUI popups
set-alias -name git -value 'C:\Program Files\Git\bin\git.exe'
git clone https://github.com/danielrode/fusion-linux
& .\fusion-linux\run.ps1 fusion
```

TODO Once container is running, remote into it.

## Building Container

GitHub builds this container automatically, and the run scirpts pull those
GitHub image builds. However, if you would like to build the image locally,
run `build.sh` before `run.sh`.
