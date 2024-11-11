# Author: Daniel Rode
# Dependencies:
#   Docker 27.1.1 OR Podman 5.2.3


# https://docs.docker.com/reference/dockerfile/


# Build the image based on the official Alpine Linux image
FROM alpine:3.20
WORKDIR /root

# Set image labels
LABEL Author="Daniel Rode"
LABEL Version="2"

# Build and install software/dependencies
RUN ash <<'EOF'
  set -e  # Exit on error

  # Install WINE
  apk update
  apk add wine

  # Install Microsoft Visual C++ 2015 Redistributable dependency
  apk add git make wget cabextract xvfb-run
  git clone "https://github.com/Winetricks/winetricks"
  cd winetricks
  make install
  cd ..
  rm -r winetricks
  winetricks
  xvfb-run winetricks --unattended vcrun2015

  # Download and install FUSION
  mkdir /opt/fusion
  cd /opt/fusion
  wget "https://forsys.sefs.uw.edu/software/fusion/fusionlatest.zip"
  unzip fusionlatest.zip
  rm fusionlatest.zip

  # Install LAS Zip support for FUSION
  cd /root
  wget "https://downloads.rapidlasso.de/LAStools.zip"
  unzip LAStools.zip
  cp LAStools/bin/LASzip.dll /opt/fusion/
  rm -r LAStools
EOF

# Install window manager (for interacting with FUSION GUI via VNC)
RUN ash <<'EOF'
  set -e  # Exit on error
  apk add \
    openbox \
    x11vnc \
    xterm \
    xvfb-run \
  ;
EOF

# Set FUSION dir as current working directory
WORKDIR /opt/fusion

# Copy assets to container image
COPY assets/init.sh assets/fusion-wrapper.sh /opt/fusion/

# Create host data mount point and set scripts executable
RUN ash <<'EOF'
  mkdir /portal
  chmod +x init.sh fusion-wrapper.sh
EOF

# Set startup script to trigger on container start
ENTRYPOINT ["/opt/fusion/init.sh"]
