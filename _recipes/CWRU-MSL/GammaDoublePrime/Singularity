Bootstrap: docker
From: nvidia/cuda:10.2-base-ubuntu18.04

%files
    ./requirements.txt /tmp/requirements.txt

%post
    apt-get update -y
    apt-get install -y --no-install-recommends git gcc python3 python3-dev python3-setuptools python3-wheel python3-pip libspatialindex-dev screen-resolution-extra libsm6 libxext6 libxrender-dev
    pip3 install -r /tmp/requirements.txt

    #clean up
    apt --purge autoremove -y
    apt clean
    rm -rf /var/lib/apt/lists/*

%runscript
    echo "Run script"

%help
    Please follow the steps :
