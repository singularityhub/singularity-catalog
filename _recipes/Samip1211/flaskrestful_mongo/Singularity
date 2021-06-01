bootstrap:docker
From:alpine:edge

%post
export PATH=/usr/local/bin:$PATH
echo "
export PATH=/usr/local/bin:$PATH" >> /environment
export LANG=C.UTF-8
echo "
export LANG=C.UTF-8" >> /environment
apk add --no-cache ca-certificates
export GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
echo "
export GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D" >> /environment
export PYTHON_VERSION=3.6.2
echo "
export PYTHON_VERSION=3.6.2" >> /environment
set -ex \

	&& apk add --no-cache --virtual .fetch-deps \

		gnupg \

		openssl \

		tar \

		xz \

	\

	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \

	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \

	&& export GNUPGHOME="$(mktemp -d)" \

	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \

	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \

	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \

	&& mkdir -p /usr/src/python \

	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \

	&& rm python.tar.xz \

	\

	&& apk add --no-cache --virtual .build-deps  \

		bzip2-dev \

		coreutils \

		dpkg-dev dpkg \

		expat-dev \

		gcc \

		gdbm-dev \

		libc-dev \

		libffi-dev \

		linux-headers \

		make \

		ncurses-dev \

		openssl \

		openssl-dev \

		pax-utils \

		readline-dev \

		sqlite-dev \

		tcl-dev \

		tk \

		tk-dev \

		xz-dev \

		zlib-dev \

	&& apk del .fetch-deps \

	\

	&& cd /usr/src/python \

	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \

	&& ./configure \

		--build="$gnuArch" \

		--enable-loadable-sqlite-extensions \

		--enable-shared \

		--with-system-expat \

		--with-system-ffi \

		--without-ensurepip \

	&& make -j "$(nproc)" \

	&& make install \

	\

	&& runDeps="$( \

		scanelf --needed --nobanner --recursive /usr/local \

			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \

			| sort -u \

			| xargs -r apk info --installed \

			| sort -u \

	)" \

	&& apk add --virtual .python-rundeps $runDeps \

	&& apk del .build-deps \

	\

	&& find /usr/local -depth \

		\( \

			\( -type d -a \( -name test -o -name tests \) \) \

			-o \

			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \

		\) -exec rm -rf '{}' + \

	&& rm -rf /usr/src/python
cd /usr/local/bin \

	&& ln -s idle3 idle \

	&& ln -s pydoc3 pydoc \

	&& ln -s python3 python \

	&& ln -s python3-config python-config
export PYTHON_PIP_VERSION=9.0.1
echo "
export PYTHON_PIP_VERSION=9.0.1" >> /environment
set -ex; \

	\

	apk add --no-cache --virtual .fetch-deps openssl; \

	\

	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \

	\

	apk del .fetch-deps; \

	\

	python get-pip.py \

		--disable-pip-version-check \

		--no-cache-dir \

		"pip==$PYTHON_PIP_VERSION" \

	; \

	pip --version; \

	\

	find /usr/local -depth \

		\( \

			\( -type d -a \( -name test -o -name tests \) \) \

			-o \

			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \

		\) -exec rm -rf '{}' +; \

	rm -f get-pip.py
pip install virtualenv
mkdir app
apk add --update curl gcc g++ \

    && rm -rf /var/cache/apk/*
ln -s /usr/include/locale.h /usr/include/xlocale.h
pip install pymongo && \

	pip install pandas && \

	pip install flask && \

	pip install flask_restful && \
	
	pip install xlrd && \
	
	pip install csv
echo "ipv6" >> /etc/modules

