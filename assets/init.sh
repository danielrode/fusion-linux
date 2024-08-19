#!/bin/sh


# Start X display server
export DISPLAY=:0
Xvfb "$DISPLAY" -screen 0 1024x768x24 >/root/xvfb.log 2>&1 &

# Wait for X display server to finish starting
while [ ! -e /tmp/.X11-unix/X0 ]
do
  sleep 0.01
done

# Spawn window manager
# xvfb-run openbox &
openbox >/root/openbox.log 2>&1 &

# Spawn VNC server (for remote desktop control)
x11vnc -no6 -forever -rfbport 5900 -ncache 10 -noxdamage \
  >/root/x11vnc.log 2>&1 &

# Spawn terminal emulator
xterm -e 'cd /opt/fusion && /bin/sh' >/root/xterm.log 2>&1 &

# Pass user command line argument along to FUSION utility wrapper script
exec /opt/fusion/fusion-wrapper.sh "$@"
