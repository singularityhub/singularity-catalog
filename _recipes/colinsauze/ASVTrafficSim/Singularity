Bootstrap:docker
From:ubuntu:18.04

%help
    Container for ASVTrafficSim

%labels
    MAINTAINER Colin Sauze

%environment
    #define environment variables here
    
%post  
    apt-get update
    apt-get -y install software-properties-common
    apt-get update
    apt-get install -y libjansson-dev python-gi-cairo build-essential python-pip git pkg-config build-essential libjansson-dev netcat psmisc
    pip install python-boatdclient python-sailsd pynmea2 libais
    git clone --recursive https://github.com/colinsauze/ASVTrafficSim.git

    #we need boatd from git, but it needs to be in a system path so manually install it
    cd /ASVTrafficSim/boatd
    python setup.py install

    cd /ASVTrafficSim/sailsd
    make
    make install
    cd ..
    cd oceansofdata/ais-exploratorium-edu/
    bunzip2 feed.ais.txt.bz2



%runscript
    cd /ASVTrafficSim/
    ./run.sh