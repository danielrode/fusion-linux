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

winget install -e --id Git.MinGit
winget install -e --id VirtualGL.TurboVNC
winget install -e --id RedHat.Podman
wsl --install --no-distribution

# WARNING: The next command will reboot your computer.
# Make sure you save any open files first.
restart-computer

function ensure-file-exists {
  new-item -ItemType directory -path (split-path $args -parent) -force
  new-item -ItemType file -path "$args" -ErrorAction silentlycontinue
}
ensure-file-exists "$($env:USERPROFILE)\.ssh\known_hosts"
git clone https://github.com/danielrode/fusion-linux
start-process powershell {
  -ExecutionPolicy bypass .\fusion-linux\run.ps1 fusion
}

# Wait for container to finish loading before running the next command to
# connect to it

& "C:\Program Files\TurboVNC\vncviewerw.bat" localhost:5900
```

## Building Container

GitHub builds this container automatically, and the run scirpts pull those
GitHub image builds. However, if you would like to build the image locally,
run `build.sh` before `run.sh`.
