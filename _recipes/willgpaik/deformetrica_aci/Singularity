BootStrap: shub
From: willgpaik/centos7_aci:gpu

%setup
  
%files

%environment
    source /opt/rh/devtoolset-8/enable
    PATH="$PATH:/opt/sw/anaconda3/bin/"
    export PATH
    PATH="/usr/local/bin/:$PATH:/usr/lib64/openmpi/bin/:/usr/local/cuda/bin"
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib/:/usr/local/cuda/lib64"
    MPI_ROOT=/usr/lib64/openmpi/
    export PATH
    export LD_LIBRARY_PATH
    export MPI_ROOT
    export BOOST_ROOT=/usr/local/

%runscript
    source /opt/rh/devtoolset-8/enable
    source /opt/sw/anaconda3/etc/profile.d/conda.sh
    source activate deformetrica
    exec "$@"

%post
    PATH="/usr/local/bin/:$PATH:/usr/lib64/openmpi/bin/:/usr/local/cuda/bin"
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib/:/usr/local/cuda/lib64"
    MPI_ROOT=/usr/lib64/openmpi/
    export PATH
    export LD_LIBRARY_PATH
    export MPI_ROOT
    export BOOST_ROOT=/usr/local/
    source /opt/rh/devtoolset-8/enable

    # Install Anaconda
    mkdir -p /opt/sw/
    cd /opt/sw/
    wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
    bash Anaconda3-2020.07-Linux-x86_64.sh -b -p /opt/sw/anaconda3
    source /opt/sw/anaconda3/etc/profile.d/conda.sh
    export PATH=$PATH:/opt/sw/anaconda3/bin/
    
    # Update conda
    conda update -y conda
    conda update -y anaconda

    conda create -y -n deformetrica python=3.8 numpy && source activate deformetrica
    conda install -y pytorch torchvision cudatoolkit=10.2 -c pytorch
    pip install pykeops
    pip install deformetrica
    
    cd /opt/sw/
    rm Anaconda3-2020.07-Linux-x86_64.sh
    rm -rf /opt/sw/anaconda3/pkgs/*
    
    
