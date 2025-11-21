# Overview

This image makes use of the [qobuz-dl python tooling](https://github.com/vitiko98/qobuz-dl). It allows for downloading unencrypted audio files from the [Qobuz streaming platform](https://www.qobuz.com). No Web UI is provided.

* A valid Qobuz subscription is required.
* Users must attach to the running container using *bash.*
* Preexisting configs and download databases can be copied to the *appdata* volume.
  * The `default_folder` entry in config.ini must be changed to `/download` in order for this to work with this image.
* If no preexisting configs are available, a new configuration will be created on first execution of qobuz-dl.
  * Please refer to the qobuz-dl repository linked above for further details.   

## Download Examples

### Single Track Download

`qobuz-dl https://open.qobuz.com/track/42890988`

### Single Album Download

`qobuz-dl https://play.qobuz.com/album/zoarc5p3ew5wb`

### Discography Download

`qobuz-dl https://play.qobuz.com/artist/62542`

# Docker Configuration

## Volumes

| Name     | Container Mount | Required Access |                     Remarks                    |
|:---------|:---------------:|:---------------:|:-----------------------------------------------|
|*appdata* |/appdata         |rw               | Stores the configuration and download database |
|*download*|/download        |rw               | Stores the downloaded files                    |

## Environment Variables

|             Name          | Value                  |                          Remarks                                         |
|:--------------------------|:----------------------:|:-------------------------------------------------------------------------|
|**QOBUZ_DL_UID**           | UID (default: 99)      | User id used to change ownership of the downloaded files for host access |           
|**QOBUZ_DL_GID**           | GID (default: 100)     | Group id used to change ownership of the downloaded files for host access|           
