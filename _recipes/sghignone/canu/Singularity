Bootstrap: docker
From: openjdk:8

%labels
        author Stefano Ghignone
        maintainer sghignone
        name CANU
        version 2.2 (released 2021-08-27) 

%environment
        export PATH=/usr/local/bin:$PATH

%post
        apt update && apt upgrade \
        && apt install -y build-essential wget gnuplot

        export LC_ALL="C.UTF-8"
        export LANG="C.UTF-8"
        echo 'export LC_ALL=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"
        echo 'export LANG=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"

        #INSTALL CANU
        export TAG="2.2"
        export OS="Linux"
        #export URL="https://github.com/marbl/canu/releases/download/v${TAG}/canu-${TAG}.Linux-amd64.tar.xz"
        export URL="https://github.com/marbl/canu/releases/download/v${TAG}/canu-${TAG}.${OS}-amd64.tar.xz"
        #wget "$URL" -O - | tar -xJf -
        curl -L "$URL" --output canu-${TAG}.${OS}.tar.xz
        tar -xJf canu-2.2.*.tar.xz 
        cd "canu-${TAG}" || exit 1
        cp -a bin/* /usr/local/bin/
        cp -a lib/* /usr/local/lib
        cp -a share/* /usr/local/share/
