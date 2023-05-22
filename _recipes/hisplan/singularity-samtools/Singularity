Bootstrap: docker
From: alpine:latest

%post

    version="1.3.1"

    apk update
    apk add ca-certificates wget
    update-ca-certificates
    wget -O /tmp/samtools-${version}.tar.bz2 https://github.com/samtools/samtools/releases/download/${version}/samtools-${version}.tar.bz2

    apk add --update --no-cache ncurses
    apk add --virtual=deps --update --no-cache ncurses-dev musl-dev g++ make zlib-dev
    cd /tmp/ && tar xjvf samtools-${version}.tar.bz2
    cd /tmp/samtools-${version} && make
    mv /tmp/samtools-${version}/samtools /usr/bin
    rm -rf /var/cache/apk/* /tmp/*
    apk del deps
    exit 0

%runscript

    exec /usr/bin/samtools "$@"


