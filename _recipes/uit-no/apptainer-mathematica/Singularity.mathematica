Bootstrap: docker
From: ubuntu:22.04

%post
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y curl gcc tzdata musl-dev python3-dev python3-pip clang
    apt-get install -y avahi-daemon wget sshpass sudo locales
    apt-get install -y locales-all ssh nano expect libfontconfig1 libgl1-mesa-glx libasound2
    apt-get install -y build-essential mosquitto mosquitto-clients libnss-mdns mdns-scan nodejs
    
    apt-get clean
    apt-get autoremove -y

    wget https://account.wolfram.com/download/public/wolfram-engine/desktop/LINUX
    bash LINUX -- -auto -verbose
    rm LINUX

%environment
    export LC_ALL=C
    export QT_QPA_PLATFORM=offscreen  # Setting Qt environment variable

%labels
    Author Radovan Bast
    Author Magnar Bjorgve

%runscript
    unset DISPLAY
    /usr/bin/wolframscript -file $@

