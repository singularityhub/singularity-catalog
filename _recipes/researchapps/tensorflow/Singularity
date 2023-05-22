BootStrap: debootstrap
OSVersion: stable
MirrorURL: http://ftp.us.debian.org/debian/

%runscript

    exec /usr/bin/python "$@"

%post
    apt-get update
    apt-get -y install vim python-pip python-dev git
    pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp27-none-linux_x86_64.whl

    mkdir -p /share/PI
    mkdir -p /scratch
    mkdir -p /local-scratch

%test
    # This runs usually less then 30 minutes depending on your host type
    python -m tensorflow.models.image.mnist.convolutional
