Bootstrap: docker
From: nvidia/cuda:latest
IncludeCmd: yes 

%files
    requirements.txt /


%post
    apt-get update
    apt-get -y upgrade
    apt-get -y install python3
    apt-get -y install python3-pip
    pip3 install --upgrade pip
    pip3 install --requirement requirements.txt
    apt-get -y install --no-install-recommends \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1


%runscript
    python3 -m model_runner_scripts.model_runner