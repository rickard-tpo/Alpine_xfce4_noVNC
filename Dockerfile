ARG ALPINE_VERSION=3.19

FROM alpine:${ALPINE_VERSION}
ARG NOVNC_VERSION=v1.4.0
ARG WEBSOCKIFY_VERSION=v0.11.0
ARG IMAGE_TAG=latest
ARG BUILD_DATE=01.01.1970

LABEL maintainer="Don <novaspirit@novaspirit.com>"
LABEL description="Simple and minimal Alpine Docker Image providing XFCE4 through html5 noVNC connection"
LABEL license="MIT"
LABEL org.opencontainers.image.version="${IMAGE_TAG}"
LABEL build-date="${BUILD_DATE}"

RUN apk add \
        alsa-lib-dev \
        alsa-plugins-pulse \
        bash \
        build-base \
        cmake \
        faenza-icon-theme \
        firefox \
        git \
        iperf3 \
        nano \
        nodejs \
        npm \
        pavucontrol \
        pulseaudio \
        pulseaudio-alsa \
        python3 \
        speedtest-cli \
        sudo \
        tcpdump \
        tigervnc \
        traceroute \
        tzdata \
        wget \
        xfce4 \
        xfce4-pulseaudio-plugin \
        xfce4-terminal \
        xrandr \
    --no-cache

RUN adduser -h /home/alpine -s /bin/bash -S -D alpine \
    && echo 'alpine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /opt/noVNC/

WORKDIR /opt

RUN git clone -b "${NOVNC_VERSION}" --single-branch https://github.com/novnc/noVNC.git /opt/noVNC  \
    && rm -rf /opt/noVNC/.git/
RUN git clone -b "${WEBSOCKIFY_VERSION}" --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify \
    && rm -rf /opt/noVNC/utils/websockify/.git/

RUN npm install --prefix /opt/noVNC ws \
    && npm install --prefix /opt/noVNC audify

COPY script.js audify.js index.html pcm-player.js /opt/noVNC/
COPY entrypoint.sh /

USER alpine
WORKDIR /home/alpine

RUN mkdir -p /home/alpine/.vnc \
    && echo -e "-Securitytypes=VncAuth" > /home/alpine/.vnc/config \
    && echo -e "#!/bin/bash\nstartxfce4 &" > /home/alpine/.vnc/xstartup \
    && echo -e "alpine\nalpine\nn\n" | vncpasswd
    # Replace alpine above to change the noVNC password. Leave the \n and \nn as they are.

USER alpine

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
