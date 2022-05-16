Bootstrap: docker
From: python:3.8

%post
    apt-get update
    apt-get install ffmpeg libsm6 libxext6 -y
    git clone https://github.com/noisysky/GYBS_hackathon.git
    cd GYBS_hackathon
    pip install -r requirements.txt

%runscript
    gybs $*

