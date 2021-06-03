BootStrap: docker
From: centos

%post
    yum -y update
    yum -y install wget bzip2 vim git npm nodejs-legacy
    wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
    bash Anaconda3-5.0.1-Linux-x86_64.sh -b -p /opt/anaconda
    rm Anaconda3-5.0.1-Linux-x86_64.sh
    export PATH=/opt/anaconda/bin:$PATH
    conda install -y -c conda-forge jupyterhub
    conda install -y notebook
    
%environment
    export PATH=/opt/anaconda/bin:$PATH
    export XDG_RUNTIME_DIR=""
