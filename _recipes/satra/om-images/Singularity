BootStrap: docker
From: debian:8.5

%post
    export LANG=C.UTF-8
    export LC_ALL=C
    apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git
    mkdir /om
    mkdir /cm
