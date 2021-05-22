Bootstrap: docker
From: ubuntu:20.04

%labels
    Maintainer Belcour A.
    Version v1.5.0
    Description Metage2Metabo metacom Singularity recipe

%environment
     export PYTHONIOENCODING=utf8

%post
     apt-get -y update && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y \
     curl \
     git \
     python3.8-dev \
     python3.8-distutils ;\
     apt-get clean ;\
     apt-get purge ;\
     curl https://bootstrap.pypa.io/get-pip.py | python3;\
     pip install graphviz;\
     pip install padmet clyngor-with-clingo clyngor pandas pipdeptree==0.13.2;\
     pip install powergrasp ete3;\
     pip install Metage2Metabo==1.5.0
