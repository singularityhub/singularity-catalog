Bootstrap: docker
From: tensorflow/tensorflow:2.3.3-gpu
Stage: build

%post
    apt update -y
    apt upgrade -y
    pip install ipython
    pip install deoxys
    pip install comet-ml
    pip install scikit-image
    pip install scikit-learn
    pip install mypy
    pip install nptyping
