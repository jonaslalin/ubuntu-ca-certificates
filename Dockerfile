ARG UBUNTU_IMAGE=docker.io/library/ubuntu:jammy-20240627.1

###############################################################################
#                          debs-for-ca-certificates                           #
###############################################################################

FROM $UBUNTU_IMAGE AS debs-for-ca-certificates

RUN --mount=type=secret,id=apt_sources,target=/etc/apt/sources.list,required=true,mode=0444 \
    --mount=type=secret,id=ca_certificates,target=/etc/ssl/certs/ca-certificates.crt,required=true,mode=0444 \
    apt-get update && \
    apt-get install -d \
        ca-certificates \
        openssl \
    && \
    rm -rf /var/lib/apt/lists/*

###############################################################################
#                               ca-certificates                               #
###############################################################################

FROM $UBUNTU_IMAGE AS ca-certificates

RUN --mount=type=bind,target=/var/cache/apt/archives/,source=/var/cache/apt/archives/,from=debs-for-ca-certificates \
    find /var/cache/apt/archives/ \
        -name "ca-certificates*.deb" \
        -o \
        -name "openssl*.deb" \
    | \
    DEBIAN_FRONTEND=noninteractive xargs dpkg -i
