ARG BASEOS_VER
FROM $BASEOS_VER

ARG APP_VER

######## changelog
# 01 [x] matplotlib: The following required packages can not be built: freetype, png -> freetype-dev, libpng-dev
# 02 [x] numpy.distutils.system_info.NotFoundError: no lapack/blas resources found -> lapack-dev
# 03 [x] h5py/h5py/api_compat.h:27:18: fatal error: hdf5.h: No such file or directory -> hdf5-dev@testing
########
#	REPOSITORY                          TAG                       IMAGE ID            CREATED             SIZE
# 	sitkevij/vmaf                 		0.6.1                     daf874147c01        About an hour ago   821MB
#   sitkevij/vmaf                       0.6.1                     814225f39c41        33 minutes ago      821MB <-- alpine:3.5 combined (4) RUN
#   sitkevij/vmaf                       0.6.1                     ff85178dd93e        7 hours ago         819MB <-- alpine:3.5 combined (6) RUN
#	sitkevij/vmaf                       1.0                       4122e7a39997        2 hours ago         896MB <-- alpine:3.5
#	sitkevij/vmaf                       latest                    4122e7a39997        2 hours ago         896MB
########

ENV CPUCOUNT 1
ENV PYTHONPATH=/vmaf/python/src:$PYTHONPATH
ENV PYTHONPATH=/vmaf:$PYTHONPATH
ENV PATH=/vmaf:/vmaf/wrapper:$PATH
RUN CPUCOUNT=$(cat /proc/cpuinfo | grep '^processor.*:' | wc -l) \

	&& echo -e '@edge http://nl.alpinelinux.org/alpine/edge/main\n@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
	&& apk update && apk add ca-certificates && update-ca-certificates \
	&& apk upgrade \

	&& apk add --no-cache \
		build-base \
		linux-headers \
		git \
		libpng-dev \
		freetype-dev \
		lapack-dev \
		gcc \
		gfortran \
		hdf5-dev@testing \

	&& apk add --no-cache \
		python \
		python-dev \
		py-pip \
		&& pip install --upgrade pip \
		&& pip install --upgrade numpy scipy matplotlib pandas \
		&& pip install --upgrade scikit-learn \
		&& pip install --upgrade h5py \
		&& rm -rf ~/.cache/pip/* \

	&& git clone --depth 1 https://github.com/Netflix/vmaf.git /vmaf \

	&& cd /vmaf && make -j${CPUCOUNT}
