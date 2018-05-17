# Resin OTA Manager for Pycom Devices


This repo consists of a [Resin](https://resin.io) image of a Pycom Over the Air (OTA) firmware (FW) and software (SW) Manager. The repo consists of two main components:
  - The server that provides the update files and generates update "manifests" (to determine the correct FW/SW to issue)
  - The library that allows a Pycom module perform updates from the server, along with an example `main.py` script

This repo is set up such that the update sever can directly run from it, when built into a resin container. It is important to be aware that **file structure is extremely important** and moving files/firmware binaries around will cause issues when generating the manifesto.

<p align="center">
<img src="images/resin-pycom.png" width="600px" >
</p>

### Installation

Begin by cloning this repo to your local environment, using the following command:

```
$ git clone https://github.com/bucknalla/resin-pycom-ota.git
```
You may wish to jump ahead to the section on [Resin Dashboard](#resin-ota-manager) to learn about provisioning resin OS to your devices.

# OTA Server

### Setup
The Pycom OTA Server will run a HTTP server on port 8000 (this can be changed in the [OTA_server.py](OTA_server.py) file). The OTA server allows for both FW and SW updates to Pycom devices.

Within this repository, there are two directories labelled `1.0.0` and `1.0.1`. These are both working examples of the OTA procedure, the only difference being the colour of the on-board LED so that a successful update can be demonstrated (Blue for `1.0.0` and green for `1.0.1`). You should upload version `1.0.0` to the module first and then via the OTA update procedure it will update to version `1.0.1`. The `pymakr.conf` associated with this project is included for ease of identifying which directory to upload. For more information, see the Pycom Libraries [OTA Example](https://github.com/pycom/pycom-libraries/tree/master/examples/OTA). Additional versions of SW may be placed into the [Pycom](Pycom/) folder, following the same versioning scheme.

You will also need to set up device/fleet variables [config.py](config.py) to add your WiFi SSID, password and the address of the update server. Ensure you make these changes in both `1.0.0` and `1.0.1` or the code will stop working after the OTA update. Additionally, if you wish to use the OTA server to update the firmware of a Pycom device, place the firmware.bin file into the [Pycom](Pycom/) directory.

**It is essential that you test the SW and FW before deploying to a device in the field as there is no way to recover a device failure.** I intend to provide examples with improved fault tolerance with regards to restoring previous firmware/software version, in later additions to this project.

# Pycom Device

### Setup

To write your own Pycom device code, navigate to the [Pycom/1.0.0/flash](Pycom/1.0.0/flash/) directory and modify the [Pycom/1.0.0/flash/main.py](Pycom/1.0.0/flash/main.py) file. Ensure to retain the OTA library and the config.py files.

To upload your own programs to the Pycom device, copy the [Pycom/1.0.0/flash](Pycom/1.0.0/flash/) directory onto the Pycom device either via USB or FTP upload.

# Resin OTA Manager

### Setup

To setup a resin device (i.e. RPI3) with OTA Manager, provision a resin device following their [getting started](https://docs.resin.io/learn/getting-started/raspberrypi3/python/) guide. Once you have reached the point of [deploying code](https://docs.resin.io/learn/getting-started/raspberrypi3/python/#deploy-code), follow the steps below:

Ensure that you are in the repository & add your resin remote
```
$ cd resin-pycom-ota
$ git remote add resin <USERNAME>@git.resin.io:<USERNAME>/<APPNAME>.git
```
*This can be found in your resin Application dashboard in the top right corner.*

Next push your local repo up to the remote
```
$ git push resin master
```

This will then build the container image and start the server running on your device. You will still need to specify settings for your server and Pycom devices.

### User Settings

In order to specify settings such as `WIFI_SSID` and `WIFI_PASS`, you will need to navigate to the `device service variable` settings tab within the Resin dashboard interface. Create variables with following options:

```
WIFI_SSID = "your-wifi-ssid"
WIFI_PW = "your-wifi-password"
SERVER_IP = "your-server-ip"
SERVER_PORT =  "your-server-port"
```

# Future Features

- [x] Allow for Device Variable Configuration
- [ ] Allow eligible devices to open Access Points for Pycom Devices
- [ ] Provide example for fault tolerant software (i.e. restore to previous firmware)
- [ ] Provide automatic firmware retrieval from Pycom servers (With options for Stable, Latest, etc. builds)
