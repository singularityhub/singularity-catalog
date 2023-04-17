BootStrap: docker
From: osrf/ros:kinetic-desktop


%post
    echo "Hello from inside the container"
    apt-get update -y
    apt-get install -y \
        software-properties-common \
        cmake \
        wget \
        lsb-release \
        sudo \
        man \
        less \
        locales \
        vim \
        git \
        mercurial \
        make \
        htop \
        terminator \
        gdb \
        zsh \
        ssh \
        nano
        apt-get clean

    add-apt-repository ppa:ubuntu-toolchain-r/test
    apt-get update -y
    apt-get install -y \
        build-essential clang-5.0 lld-5.0 g++-7 ninja-build python python-pip python-dev tzdata sed curl wget unzip autoconf libtool

    pip install setuptools nose2

    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list

    wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
    echo "deb http://packages.osrfoundation.org/gazebo/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list
    apt-get update

    apt-get install -q -y ros-kinetic-desktop-full
    apt-get install -q -y ros-kinetic-pcl-ros
    apt-get install -q -y ros-kinetic-opencv3
    apt-get install -q -y libeigen3-dev
    update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-5.0/bin/clang++ 101
    update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-5.0/bin/clang 101

    sudo -H apt-get install ros-kinetic-ackermann-msgs

    echo "removing cmake"
    apt remove -y cmake
    echo "purge cmake"
    apt purge -y --auto-remove cmake
    echo "choosing version"
    version=3.9
    echo "choosing build"
    build=6
    mkdir ~/temp
    cd ~/temp
    wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
    tar -xzvf cmake-$version.$build.tar.gz
    cd cmake-$version.$build/
    ./bootstrap
    make -j8
    make install

%runscript
    echo "This is what happens when you run the container..."

