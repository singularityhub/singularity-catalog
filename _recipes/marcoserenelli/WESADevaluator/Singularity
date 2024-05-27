Bootstrap: docker
From: nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

%post
    apt-get -y update
    apt-get -y install python3 python3-pip python3-venv git wget unzip
    mkdir -p /opt/myproject
    cd /opt/myproject
    git clone https://github.com/marcoserenelli/WESADevaluator.git .
    python3 -m venv venv
    . venv/bin/activate
    pip install -r requirements.txt
    mkdir -p tmp/data
    wget -v https://uni-siegen.sciebo.de/s/HGdUkoNlW1Ub0Gx/download -O tmp/data/WESAD.zip
    unzip tmp/data/WESAD.zip -d data
    rm tmp/data/WESAD.zip

%runscript
    cd /opt/myproject
    . venv/bin/activate
    exec python3 main.py "$@"