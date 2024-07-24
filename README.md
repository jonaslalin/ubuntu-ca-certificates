# ubuntu-ca-certificates

## 1.

```sh
cp templates/* .
```

## 2.

```sh
. utils.sh
```

then

```sh
pull_ubuntu_image
```

or

```sh
pull_ubuntu_image registry.example.com/ubuntu:jammy-20240627.1
```

## 3.

```sh
podman build \
    --build-arg-file=argfile.conf \
    --no-cache \
    --pull=never \
    --secret=id=apt_sources,src=sources.list \
    --secret=id=ca_certificates,src=ca-certificates.crt \
    --security-opt=label=disable \
    --tag=ubuntu-ca-certificates:latest \
    .
```

## 4.

```sh
podman run --interactive --rm --tty ubuntu-ca-certificates:latest
```
