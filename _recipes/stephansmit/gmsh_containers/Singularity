Bootstrap: docker
From: ubuntu:16.04

%environment
    PATH=$PATH:/opt/gmsh-4.4.0-Linux64/bin
    export PATH

%post
    echo "Update apt-get"
    apt-get -y update && \
    apt-get -y install libglu1 libxrender-dev libxcursor1 libxft2 libxinerama1 wget

    wget http://gmsh.info/bin/Linux/gmsh-4.4.0-Linux64.tgz -P /opt
    echo "Install python3"
    apt-get -y install python3-matplotlib python3-pip
  
    echo "Install python packages"
    python3 -m pip install --upgrade pip numpy
    python3 -m pip install pandas pygmsh CoolProp meshio==3.0.0

    echo "Extract gmsh"
    tar zxvf  /opt/gmsh-4.4.0-Linux64.tgz -C /opt
%runscript
     exec /opt/gmsh-4.4.0-Linux64/bin/gmsh "$@"   
