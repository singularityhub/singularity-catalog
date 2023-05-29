Bootstrap: docker
From: ubuntu:16.04

# sudo singularity build expfactory-robots.simg Singularity

%setup
    mkdir -p ${SINGULARITY_ROOTFS}/code
    mkdir -p ${SINGULARITY_ROOTFS}/data

%files
. /code

%labels
    MAINTAINER vsochat@stanford.edu

%post
    apt-get update && apt-get install -y git wget python3-pip \
                   python3-dev xvfb libfontconfig fonts-liberation \
                   gconf-service libappindicator1 libasound2 libnspr4 \
                   libnss3 libxss1 lsb-release xdg-utils
    cd /opt && git clone https://www.github.com/expfactory/expfactory
    wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    cd /opt/expfactory && python3 setup.py install
    python3 -m pip install selenium pyvirtualdisplay

    cd /opt && dpkg -i google-chrome-stable_current_amd64.deb
    apt-get -f install
    apt-get install -y -f
    rm google-chrome-stable_current_amd64.deb

    cd /code && chmod u+x /code/start.py

%runscript
    exec python3 /code/start.py "$@"
