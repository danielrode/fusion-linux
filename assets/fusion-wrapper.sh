#!/bin/sh


cd /opt/fusion

# Ensure user entered valid FUSION utility name
fusion_util_path="$1".exe
if [ ! -f "$fusion_util_path" ]
then
  if [ -z "$1" ]
  then
    echo "No FUSION utility specified"
  else
    echo "error: FUSION utility not found: $fusion_util_path"
  fi
  echo "Available FUSION utilities:"
  for i in *.exe
  do
    basename "$i" .exe
  done
  exit 1
fi

# Execute FUSION utility via WINE
fusion_util="$1"
shift
wine "$fusion_util".exe "$@"
