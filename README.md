# vmaf Docker

There are two ways to run Netflix VMAF Docker:

## 1. Pull from Docker Hub

- [vmaf alpine/latest](https://github.com/sitkevij/vmaf/tree/master/alpine)
  - `docker pull sitkevij/vmaf` OR `docker pull sitkevij/vmaf:0.6.1`

## 2. Building from source
If building from source, Docker 17.05 or higher is required due to `ARG` usage.
```
$ git clone https://github.com/sitkevij/vmaf.git && \
cd vmaf && \
chmod a+x *.sh && \
./build-arg.sh sitkevij vmaf:0.6.1-alpine:3.5 && \
./unit-test-media.sh && \
./unit-test.sh
```