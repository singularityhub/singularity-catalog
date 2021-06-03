Bootstrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%post
    apt update
    apt install -y software-properties-common
    apt-add-repository universe
    apt update
    apt install -y git wget build-essential
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    echo 'export LC_ALL=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"
    echo 'export LANG=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"
    echo "export PATH=/usr/local:/usr/local/bin:$PATH" >> "$SINGULARITY_ENVIRONMENT"

    # ================================
    # INSTALL pistis
    # ================================
    NAME="pistis"
    VERSION="0.3.4"
    TARBALL="${NAME}.tar.gz"
    URL="https://github.com/mbhall88/${NAME}/archive/v${VERSION}.tar.gz"
    SHA256="152938e16ecd6f2997f17018ba9f56050f54871707d2f5fe5eb47a3d8810d943"
    wget -O "$TARBALL" "$URL"

    SUCCESS=0
    if [[ $(shasum -a 256 $TARBALL | cut -f1 -d " ") == "$SHA256" ]]; then
        SUCCESS=1
    fi

    if [[ $SUCCESS != 1 ]]; then
        echo "ERROR: unable to download the following URL with the shasum $SHA256:"
        echo "=====> $URL"
        exit 1
    fi

    mkdir "$NAME" || exit 1
    tar xzf "$TARBALL" -C "$NAME" --strip-components 1
    rm "$TARBALL"
    cd "$NAME"
    apt install -y python3-pip
    pip3 install .

%test
    NAME="pistis"
    command -v "$NAME" >/dev/null 2>&1 || \
        { echo >&2 "I require $NAME but it's not installed.  Aborting."; exit 1; }
