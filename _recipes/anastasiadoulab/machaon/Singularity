Bootstrap: docker

From: continuumio/anaconda3

%setup
    mkdir -p ${SINGULARITY_ROOTFS}/opt/src
    mkdir -p ${SINGULARITY_ROOTFS}/opt/config
    mkdir -p ${SINGULARITY_ROOTFS}/opt/setup
    mkdir -p ${SINGULARITY_ROOTFS}/opt/test

%files
    environment.yml /opt
    src/* /opt/src
    config/* /opt/config
    setup/* /opt/setup
    test/* /opt/test

%post
    cd /opt
    apt-get update
    apt-get install -y build-essential cmake libboost-all-dev libbz2-dev libgl1-mesa-dev libpoppler-cpp-dev 
    g++ -static -O3 -ffast-math -lm -o /opt/src/TMalign /opt/src/TMalign.cpp 
    chmod 770 /opt/src/TMalign
    git clone https://github.com/mhekkel/mrc.git 
    cd mrc
    mkdir build
    cd build
    cmake ..
    cmake --build . --config Release
    ctest -C Release
    cmake --install .
    cd /opt
    git clone https://github.com/PDB-REDO/libcifpp.git
    cd libcifpp
    mkdir build
    cd build
    cmake ..
    cmake --build . --config Release
    ctest -C Release
    cmake --install .
    cd /opt
    git clone https://github.com/PDB-REDO/dssp.git
    cd dssp
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/opt/src -DCMAKE_PREFIX_PATH=/root/.local/lib/cmake/cifpp ..
    cmake --build . --config Release
    ctest -C Release
    cmake --install .
    cd /opt
    /opt/conda/bin/conda env create -f environment.yml

