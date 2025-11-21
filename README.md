# Overview

This image makes use of the [qobuz-dl python tooling](https://github.com/vitiko98/qobuz-dl). It allows for downloading unencrypted audio files from the [Qobuz streaming platform](https://www.qobuz.com). No Web UI is provided.

* A valid Qobuz subscription is required.
* Users must attach to the running container using *bash.*
* Preexisting configs and download databases can be copied to the *appdata* volume.
  * The `default_folder` entry in config.ini must be changed to `/download` in order for this to work with this image.
* If no preexisting configs are available, a new configuration will be created on first execution of qobuz-dl.
  * Please refer to the qobuz-dl repository linked above for further details.   

## Lazy Download Examples

This simplifies the use of qobuz-dl a little by taking the steps mentioned in the next section out of the equation.

### Single Track Download

`qobuz-dl https://open.qobuz.com/track/42890988`

### Single Album Download

`qobuz-dl https://play.qobuz.com/album/zoarc5p3ew5wb`

### Discography Download

`qobuz-dl https://play.qobuz.com/artist/62542`

## (Slightly more) Involved Download Example

### Steps

1. Activate the virtual environment. **This is required before using qobuz-dl**.
   /app/qobuz-dl# `source bin/activate`
2. Execute the qobuz-dl script
   /app/qobuz-dl# `python -m qobuz_dl.cli dl https://play.qobuz.com/artist/62542`
3. Change ownership of the downloaded files for host access
3. Deactivate the virtual environment
   /app/qobuz-dl# `deactivate`

### qobuz-dl Download Parameters

In order to see the parameters available for manually executing qobuz-dl, enter

`python -m qobuz_dl.cli dl --help`

**Note that the easiest way is to configure your preferred parameters in *config.ini*.**

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
