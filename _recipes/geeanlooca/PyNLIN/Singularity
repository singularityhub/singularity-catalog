Bootstrap: docker
From: python:3.10.3-bullseye

%post
    apt update
    apt install git
    git clone https://github.com/geeanlooca/PyNLIN
    cd PyNLIN
    git checkout dev
    python -m pip install .
    make install
    
%runscript
    python -c "import pynlin"
