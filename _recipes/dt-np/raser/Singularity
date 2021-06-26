Bootstrap: docker
From: rootproject/root:6.24.00-ubuntu20.04 

%post
    apt update
    apt -y install --no-install-recommends fenics
    apt -y install tk-dev
    apt -y install python3-tk
    apt -y install vim 

    wget https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    python3 -m pip install matplotlib

    apt -y install build-essential  
    apt -y install cmake
    apt -y install libgl1-mesa-dev libglu1-mesa-dev libxt-dev libxmu-dev libxi-dev zlib1g-dev libgl2ps-dev libexpat1-dev libxerces-c-dev 

    wget https://geant4-data.web.cern.ch/releases/geant4.10.07.p02.tar.gz
    tar xzf geant4.10.07.p02.tar.gz
    cd geant4.10.07.p02
    mkdir build && cd build
    cmake ../
    make -j12 
    make install 

%environment
    export AAA=aaa
    export BBB=bbb
    export CCC=ccc

%runscript
    echo "Hello World"


