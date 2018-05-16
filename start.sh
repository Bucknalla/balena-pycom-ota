#!/bin/bash

# Populate config.py with user info
# echo "SERVER_IP = ""\""$(hostname -I | awk '{print $1}')"\"" > config.py
echo 'SERVER_IP = "'"$SERVER_IP"'" ' > config.py
echo 'SERVER_PORT = '"$SERVER_PORT"' ' >> config.py
echo 'WIFI_SSID = "'"$WIFI_SSID"'" ' >> config.py
echo 'WIFI_PASS = "'"$WIFI_PASS"'" ' >> config.py
echo 'SERVER_PORT = '"$SERVER_PORT"' ' >> config.py

# Link configuration script to SW stores
ln config.py Pycom/1.0.0/flash/config.py
ln config.py Pycom/1.0.1/flash/config.py

python OTA_server.py