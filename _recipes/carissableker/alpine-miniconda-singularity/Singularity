BootStrap: library
From: alpine:3.7

%environment
    CONDA_DIR=/opt/miniconda/
    export PATH=$CONDA_DIR/bin/:$PATH
    . $CONDA_DIR/etc/profile.d/conda.sh
    conda activate base

%runscript
    echo "This is an Alpine OS container with miniconda. "

%test
    conda info --envs

%post
    ##################################
    # Configure packages and glibc
    ##################################

    GLIBC_VER=2.32-r0
    
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --update add \
    bash \
    curl \
    ca-certificates \
    libstdc++ \
    glib 
    curl "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" -o /etc/apk/keys/sgerrand.rsa.pub \
 && curl -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VER/glibc-$GLIBC_VER.apk" -o glibc.apk \
 && apk add glibc.apk
    curl -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VER/glibc-bin-$GLIBC_VER.apk" -o glibc-bin.apk \
 && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/$GLIBC_VER/glibc-i18n-$GLIBC_VER.apk" -o glibc-i18n.apk \
 && apk add glibc-bin.apk glibc-i18n.apk \
 && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc/usr/lib \
 && rm -rf glibc*apk /var/cache/apk/*
    
    ##################################
    # Configure and install conda    
    ##################################
    
    CONDA_VER=4.8.3
    CONDA_MD5_SUM=879457af6a0bf5b34b48c12de31d4df0ee2f06a8e68768e5758c3293b2daf688
    CONDA_DIR=/opt/miniconda/

    curl -L  https://repo.anaconda.com/miniconda/Miniconda3-py38_$CONDA_VER-Linux-x86_64.sh -o miniconda.sh \
 && echo "$CONDA_MD5_SUM  miniconda.sh" | sha256sum -c - \
 && /bin/bash miniconda.sh -f -b -p $CONDA_DIR \
 && rm miniconda.sh 
    find $CONDA_DIR -follow -type f -name '*.a' -delete \
 && find $CONDA_DIR -follow -type f -name '*.js.map' -delete \
 && $CONDA_DIR/bin/conda clean -tipy -af


%labels
    Author carissarobyn.bleker@nib.si
    Version v0.0.1

%help
    Container with Alpine OS and miniconda installed in /opt/miniconda. 
    Inspired by:
        * continuumio/miniconda3:4.8.2-alpine (https://hub.docker.com/layers/continuumio/miniconda3/4.8.2-alpine/images/sha256-b9c9f2c7748abdb3291ef2e9b04a8ef3e355f0d7e8030e7a07b8f26c11ed88be?context=explor)
        * https://github.com/Docker-Hub-frolvlad/docker-alpine-miniconda3
        * https://github.com/show0k/alpine-jupyter-docker
        * https://github.com/hpcng/singularity/issues/5075
