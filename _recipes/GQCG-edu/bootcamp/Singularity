Bootstrap: docker
From: ubuntu:20.04
Stage: build

%environment
    export DEBIAN_FRONTEND=noninteractive
    export PATH="/usr/local/miniconda3/bin:${PATH}"

%post
    export DEBIAN_FRONTEND=noninteractive
    apt-get update 
    apt-get install -y build-essential wget pandoc texlive-full biber latexmk make git procps locales curl openssh-client
    apt-get clean 
    apt-get autoremove -y

    wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh
    bash Miniconda3-py38_4.12.0-Linux-x86_64.sh -p /usr/local/miniconda3 -b
    rm -f Miniconda3-py38_4.12.0-Linux-x86_64.sh

    export PATH="/usr/local/miniconda3/bin:${PATH}"

    conda --version

    pip install pyscf numpy scipy matplotlib ipython jupyter pandas sympy h5py scikit-learn

    NOW=`date`
    echo "export NOW=\"${NOW}\"" >> $SINGULARITY_ENVIRONMENT
