# vmaf Docker

[![](https://images.microbadger.com/badges/image/sitkevij/vmaf.svg)](https://microbadger.com/images/sitkevij/vmaf "docker layers") [![](https://images.microbadger.com/badges/version/sitkevij/vmaf.svg)](https://microbadger.com/images/sitkevij/vmaf "release version")

There are two ways to get VMAF Docker:

## 1. Pull from Docker Hub

- [vmaf alpine/latest](https://github.com/sitkevij/vmaf/tree/master/alpine)
  - `docker pull sitkevij/vmaf` OR `docker pull sitkevij/vmaf:0.6.2`

## 2. Building from source
If building from source, Docker 17.05 or higher is required due to `ARG` usage.
```
git clone https://github.com/sitkevij/vmaf.git && \
 cd vmaf && \
 chmod a+x *.sh && \
 ./build-arg.sh sitkevij vmaf:0.6.2-alpine:3.7 && \
 ./unit-test-media.sh && \
 ./unit-test.sh
```

## Running vmaf Docker
vmaf Docker can be run by prefixing `run_vmaf` commands with `docker run --rm -v="$(pwd)":/tmp/vmaf sitkevij/vmaf`

### Example
```
docker run --rm -v="$(pwd)":/tmp/vmaf sitkevij/vmaf run_vmaf yuv420p 1920 800 "${file1}.yuv" "${file2}.yuv" --out-fmt json
```

### vmaf usage
```
usage: run_vmaf fmt width height ref_path dis_path [--model model_path] [--out-fmt out_fmt] [--phone-model]

fmt:
    yuv420p
    yuv422p
    yuv444p
    yuv420p10le
    yuv422p10le
    yuv444p10le

out_fmt:
    text (default)
    xml
    json
```

## Developer notes

### Image sizing

#### Untouched `/vmaf` directory
```
/vmaf # du
258.0M  .
```

1. `rm -rf /vmaf/.git` -> 197.9M

2. `rm - rf /vmaf/python/test/resource/yuv` -> 59.4M

```
/vmaf # du -h -d 1
2.9M    ./pthreads
76.0K   ./Xcode
10.0M   ./ptools
1.4M    ./libsvm
68.0K   ./workspace
12.0M   ./python
2.3M    ./matlab
1.3M    ./model
1.6M    ./feature
24.5M   ./wrapper
64.0K   ./gradle
2.9M    ./resource
59.4M   .
```

3. `rm -rf /vmaf/ptools/opencontainers_1_8_4/docs && rm -rf /vmaf/ptools/opencontainers_1_8_4/tests/` -> 56.2M

#### Total image size
```
0.6.2 204MB
```
https://hub.docker.com/r/sitkevij/vmaf/tags/