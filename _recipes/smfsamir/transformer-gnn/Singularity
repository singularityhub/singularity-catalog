Bootstrap: docker
From: nvcr.io/nvidia/pytorch:21.07-py3

%environment
    SHELL=/bin/bash

%post 
    git clone https://github.com/NVIDIA/apex
    cd apex
    pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--fast_multihead_attn" ./

%runscript
    exec /bin/bash