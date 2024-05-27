Bootstrap: debootstrap
MirrorURL: http://archive.ubuntu.com/ubuntu/
OSVersion: xenial
Include: software-properties-common
%post
    apt-add-repository -y multiverse
    apt-add-repository -y universe
    apt-get update
    apt-get install -y python3-pip
    pip3 install notebook
