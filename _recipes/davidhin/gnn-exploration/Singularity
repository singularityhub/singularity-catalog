Bootstrap:docker
From:pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

%labels
    MAINTAINER admin
    WHATAMI admin

%environment
    PATH=${PATH}:/joern

%files
    cli.sh /cli.sh
    requirements.txt /requirements.txt

%runscript
    exec /bin/bash /cli.sh "$@"

%post
    chmod u+x /cli.sh

    # Update
    apt update
    apt install -y software-properties-common
    add-apt-repository universe
    apt update
    apt install -y wget build-essential git graphviz python-dev python3-dev

    # Install miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b

    # Install python dependencies here
    pip install -r /requirements.txt
    conda install -y pygraphviz
    python -c 'import nltk; nltk.download("punkt")'

    # Install Java build dependencies
    apt install -y gradle 

    # Install Joern Old
    git clone https://github.com/octopus-platform/joern.git
    cd joern
    bash build.sh
    mv joern-parse old-joern-parse
    cd /

    # Install Joern New
    apt install -y openjdk-8-jdk git curl gnupg bash unzip sudo wget 
    wget https://github.com/ShiftLeftSecurity/joern/releases/latest/download/joern-install.sh
    chmod +x ./joern-install.sh
    printf 'Y\n/bin/joern\ny\n/bin\n\n' | sudo ./joern-install.sh --interactive
