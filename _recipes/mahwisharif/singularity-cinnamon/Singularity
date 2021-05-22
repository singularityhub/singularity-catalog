BootStrap:debootstrap 
OSVersion: xenial
MirrorURL:  http://us.archive.ubuntu.com/ubuntu/

%runscript
    echo "Going to set up and install - please wait....."
    lsb_release -a
    echo "checking cmake version..."
    cmake --version
    echo "checking make version..."
    make --version
    echo "checking gcc version..."
    gcc --version
    echo "checking bison version..."
    bison --version
 
%post
    apt-get install -y software-properties-common
    add-apt-repository universe
    apt-get update
    apt-get -y install sudo 
    apt-get -y install build-essential curl git man wget vim autoconf libtool bison flex cmake clang-3.8 libelf-dev libboost-all-dev libdwarf-dev zlib1g-dev libtbb-dev binutils-dev libiberty-dev
    apt -y install python
    apt-get clean
    
%help

%test
 
%environment

