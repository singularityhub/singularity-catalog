Bootstrap:docker
From:ubuntu:18.04

%help
    Container for Sails and Boatd

%labels
    MAINTAINER Colin Sauze

%environment
    #define environment variables here
    
%post  
    apt-get update
    apt-get -y install software-properties-common
    apt-get update
    apt-get install -y libjansson-dev python3-gi-cairo python3-gi gir1.2-gtk-3.0 build-essential python3-pip git pkg-config build-essential libjansson-dev netcat psmisc python3-yaml python3-numpy
    pip3 install python-sailsd python-boatdclient

    cd /opt
    git clone --recursive https://github.com/abersailbot/simulator.git

    #we need boatd from git, but it needs to be in a system path so manually install it
    cd /opt/simulator/boatd
    python3 setup.py install

    #compile sailsd
    cd /opt/simulator/sailsd
    make
    make install
    cd ..

    #change boatdclient to port 2223
    ./set_port.sh

%runscript
    cd /opt/simulator/
    ./run.sh
