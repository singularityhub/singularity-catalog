Bootstrap: docker
From: rootproject/root:6.24.00-ubuntu20.04 

%post
    apt update
    apt -y install --no-install-recommends fenics
    apt -y install tk-dev
    apt -y install python3-tk
    apt -y install vim 
    wget https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    python3 -m pip install matplotlib

%environment
    export AAA=aaa
    export BBB=bbb
    export CCC=ccc

%runscript
    echo "Hello World"


