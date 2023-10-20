ARG REGISTRY_URL=docker.io/library
ARG UBUNTU_VERSION=jammy-20231004

FROM $REGISTRY_URL/ubuntu:$UBUNTU_VERSION AS ca-certificates

WORKDIR /var/cache/apt/archives/

RUN --mount=type=bind,target=/etc/ssl/certs/ca-certificates.crt,source=ca-certificates.crt \
    --mount=type=bind,target=/etc/apt/sources.list,source=sources.list \
    apt-get update && \
    apt-get install --download-only -y \
        ca-certificates \
        openssl \
    && rm -rf /var/lib/apt/lists/*

FROM $REGISTRY_URL/ubuntu:$UBUNTU_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN --mount=type=bind,target=/var/cache/apt/archives/,source=/var/cache/apt/archives/,from=ca-certificates \
    find /var/cache/apt/archives/ \
        -name "ca-certificates*.deb" -o \
        -name "openssl*.deb" \
    | xargs dpkg -i
