Bootstrap: docker
From: python:3.10.3-bullseye

%post
    apt update
    apt install git
    git clone https://github.com/geeanlooca/PyNLIN
    python -m pip install PyNLIN/

%runscript
    python -c "import pynlin"
