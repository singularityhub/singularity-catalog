Bootstrap: docker
From: debian:bookworm-slim

%files
    matrixA.txt /cnt/matrixA.txt
    matrixB.txt /cnt/matrixB.txt
    CMakeLists.txt /cnt/CMakeLists.txt
    ./src /cnt/src
    ./include /cnt/include
    ./lib /cnt/lib
    ./googletest /cnt/googletest
    ./test /cnt/test

%post
    # install openmpi
    apt-get update && 
    apt-get upgrade -y && 
    apt-get autoremove -y &&
    apt-get clean -y &&
    apt-get -y install g++ cmake libopenmpi-dev &&
    apt-get autoremove -y &&
    apt-get clean -y

    # build
    cd cnt
    mkdir -p build && cd build
    cmake ..
    cmake --build .
    cd ..
    
%runscript
    echo "Container was created."
    
    cd cnt
    # run test
    build/test_multiplication
    # main
    # mpirun -np 2 main