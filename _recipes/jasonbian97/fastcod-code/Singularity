Bootstrap: docker
From: ubuntu:18.04

%post -c /bin/bash

    cd /

    # Prepare directories for installing applications
    mkdir -p APPS
    mkdir -p INSTALLERS

    # Update all libraries
    apt-get -y update

    # Install MRTrix3
    apt-get -y install git g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev python3-distutils
    cd APPS
    git clone https://github.com/MRtrix3/mrtrix3.git
    cd mrtrix3
    git checkout 3.0.3
    ./configure
    ./build
    cd /
    
    # Make custom folders
    mkdir -p CODE

    # Set Permissions
    chmod 755 /APPS
    chmod 755 /CODE
    
    # Install source code
    cd /
    apt-get -y install wget git gcc libpq-dev python-dev python-pip python3 python3.8 python3.8-venv python3.8-dev python3-dev python3-pip python3-venv python3-wheel libpng-dev libfreetype6-dev libblas3 liblapack3 libblas-dev liblapack-dev pkg-config
    cd /INSTALLERS
    git clone https://github.com/jasonbian97/fastcod-code.git
    cd fastcod-code
    mv src /CODE
    cd /CODE
    python3.8 -m venv fastcod_env
    source fastcod_env/bin/activate
    pip install --upgrade pip
    pip3 install wheel
    pip install -r /INSTALLERS/fastcod-code/pip_install_env.txt
    deactivate

    cd /

    # Clean up
    rm -r /INSTALLERS

%environment

    # MRTrix3
    export PATH="/APPS/mrtrix3/bin:$PATH"

%runscript
#!/bin/bash

    source /CODE/fastcod_env/bin/activate
    cd /CODE/src
    python "$@"

    # "$@" passes any additional arguments provided to the container to the script.
