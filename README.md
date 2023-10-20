# ubuntu-ca-certificates

```sh
IMAGE_VERSION=jammy-20231004

docker build --build-arg UBUNTU_VERSION=$IMAGE_VERSION --no-cache -t ubuntu-ca-certificates:$IMAGE_VERSION .
```
