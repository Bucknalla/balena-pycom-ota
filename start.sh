#!/bin/bash

# Populate config.py with user info
# echo "SERVER_IP = ""\""$(hostname -I | awk '{print $1}')"\"" > config.py
echo 'SERVER_IP = "'"$SERVER_IP"'" ' > config.py
echo 'SERVER_PORT = '"$SERVER_PORT"' ' >> config.py
echo 'WIFI_SSID = "'"$WIFI_SSID"'" ' >> config.py
echo 'WIFI_PASS = "'"$WIFI_PASS"'" ' >> config.py

# Link configuration script to SW stores
for dir in Pycom/* ; do
   if [ -d "${dir}/flash/" ]; then
       echo "Found version: $(basename $dir)"
       ln --force config.py "${dir}/flash/config.py"
   fi
done

echo "Starting OTA Server"
python Pycom/OTA_server.py

function cleanup {
  echo "Cleaning up config.py"
  > config.py
}

trap cleanup EXIT