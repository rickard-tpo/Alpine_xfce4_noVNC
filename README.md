Based on the work of https://github.com/novaspirit/ and https://github.com/nett00n

Changes include adding a few network troubleshooting tools as well as simple authentication for VNC. 



# Alpine xfce4 noVNC

Simple and minimal Alpine Docker Image providing XFCE4 through html5 noVNC connection

Step by step tutorial on how this docker is created (<https://www.youtube.com/watch?v=8IfTXJRAIJw>)

<div align="center">

[![Discord](https://img.shields.io/discord/316245914987528193?logo=discord)](https://discord.com/invite/v8dAnFV)
[![Youtube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)
[![Twitter URL](https://img.shields.io/twitter/follow/novaspirittech?style=flat-square&logo=twitter)](https://twitter.com/novaspirittech)

![GitHub repo size](https://img.shields.io/github/repo-size/novaspirit/Alpine_xfce4_noVNC?label=Repo%20Size&logo=github)
![Docker Build](https://github.com/novaspirit/Alpine_xfce4_noVNC/workflows/Docker/badge.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/novaspirit/alpine_xfce4_novnc)
![Docker Size](https://img.shields.io/docker/image-size/novaspirit/alpine_xfce4_novnc)

![preview](preview.png?raw=true "preview")

</div>

## Updates

v0.1.2 removed password requirement for noVNC

v0.1.1 added firefox pulseaudio and audio support

v0.1.0 initial code

## Build Image

### Build using plain Docker

```shell
git clone https://github.com/novaspirit/Alpine_xfce4_noVNC.git
docker build -t alpine-xfce4 Alpine_xfce4_noVNC/
```

### Build using Docker Compose

```shell
git clone https://github.com/novaspirit/Alpine_xfce4_noVNC.git
cd Alpine_xfce4_noVNC
docker-compose build
```

Image builds automatically, when [starting compose](#run-using-docker-compose).
You can skip this step.

## Run Image

### Run using plain Docker

```shell
docker run -it -p 6080:6080 -p 56780:56780 --name alpine-novnc alpine-xfce4
```

### Run using Docker Compose

```shell
docker-compose up -d
```

If you want to force rebuild

```shell
docker-compose up -d --build --no-cache
```

You can set environmental values in `.env` file

### Environment

#### Build arguments

- `ALPINE_VERSION` - alpine linux docker image tag
- `NOVNC_VERSION` - version of noVNC. [Releases page](https://github.com/novnc/noVNC/releases)
- `WEBSOCKIFY_VERSION` - Version of Websockify. [Releases page](https://github.com/novnc/websockify/releases)
- `IMAGE_TAG` - name of building image tag
- `BUILD_DATE` - date of building image

#### Runtime environmental variables

- `ALPINE_PASSWORD` - change password for user `alpine`
- `PUBLIC_HTTP_PORT` - set port for access to novnc.
  `16080:6080` would publish novnc on `16080` port.
  `6080` would automatically map random port.
- `SCREEN_RESOLUTION` - You can preset screen resolution for noVNC. Default values for resolution:
  - "1024x768"
  - "1920x1200"
  - "1920x1080"
  - "1600x1200"
  - "1680x1050"
  - "1400x1050"
  - "1360x768"
  - "1280x1024"
  - "1280x960"
  - "1280x800"
  - "1280x720"
  - "800x600"
  - "640x480"
- `TZ` - You can set TimeZone

## Connect With noVNC

Use modern browswer to connect to http://(docker ip):6080

## LICENCE

[MIT](./LICENSE.md)
