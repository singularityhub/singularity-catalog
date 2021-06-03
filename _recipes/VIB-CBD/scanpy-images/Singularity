Bootstrap: docker

From: danigoland/py36-alpine-llvm6

%files
    ./requirements.txt /tmp/

%environment
    PYTHONPATH=/usr/lib/python3.6/site-packages/:/usr/lib/python3.6/:/usr/lib/python3.6/lib-dynload/:${PYTHONPATH}
    export PYTHONPATH

%post 
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.8/main" >> /etc/apk/repositories
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.8/community" >> /etc/apk/repositories
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/testing" >> /etc/apk/repositories

    apk add --no-cache --virtual scanpy-runtime python3 bash git zlib hdf5 libgfortran libgcc libstdc++ musl openblas tcl tk libxml2 libffi && \
    apk add --no-cache --virtual .build-deps build-base wget git python3-dev zlib-dev hdf5-dev freetype-dev libtool m4 autoconf automake patch bison flex\
    libpng-dev openblas-dev tcl-dev tk-dev libxml2-dev zlib-dev linux-headers libffi-dev cmake && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    export LC_ALL="en_US.UTF-8" 

    cd /tmp/ && \
    git clone https://github.com/igraph/igraph.git && \
    cd igraph && \
    git checkout 6faf561 && \
    ./bootstrap.sh && \
    ./configure && make && make install

    cd /tmp/ && \
    git clone https://github.com/igraph/python-igraph.git && \
    cd python-igraph && \
    git checkout b570c4c && \
    python3 setup.py install

    ln -s /usr/lib/python3.6/site-packages/python_igraph-0.7.1.post6-py3.6-linux-x86_64.egg/igraph /usr/lib/python3.6/site-packages/igraph

    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir "numpy==1.16.1" && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt

    apk del .build-deps && \
    rm -rf /var/cache/apk/*
