Bootstrap:docker
From:pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

%labels
    MAINTAINER admin
    WHATAMI admin

%files
    cli.sh /cli.sh
    requirements.txt /requirements.txt

%runscript
    exec /bin/bash /cli.sh "$@"

%post
    chmod u+x /cli.sh

    # Update
    apt update
    apt install -y wget build-essential git

    # Install miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b

    # Install Java build dependencies
    apt install -y gradle graphviz-dev

    # Install dependencies here
    pip install -r /requirements.txt
