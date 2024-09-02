Bootstrap: docker
From: ubuntu:18.04

%files
    # Prepare directories for installing applications
    /nfs/masi/kanakap/projects/DeepN4/src/trained_model_Synbo_UNet3D/checkpoint_epoch_264 /extra/checkpoint_epoch_264
    /nfs/masi/kanakap/projects/DeepN4/venv/pip_install_deepn4.txt /extra/pip_install_deepn4.txt

%post -c /bin/bash
    cd /

    # Prepare directories for installing applications
    mkdir -p APPS
    mkdir -p INSTALLERS
    mkdir -p INPUTS
    mkdir -p OUTPUTS

    # Update all libraries
    apt-get -y update

    # Install xvfb
    apt-get -y install xvfb

    # Install FreeSurfer
    apt-get -y install wget bc binutils libgomp1 perl psmisc sudo tar tcsh unzip uuid-dev vim-common libjpeg62-dev
    wget -O /INSTALLERS/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz "https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz"
    tar -C /APPS -xzvf /INSTALLERS/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
    echo "This is a dummy license file. Please bind your freesurfer license file to this file." > /APPS/freesurfer/license.txt
    cd /

    # Make custom folders
    mkdir -p src

    # Set Permissions
    chmod 755 /src

    # Install source code
    cd /
    apt-get -y install wget git gcc libpq-dev python-dev python-pip python3 python3.8 python3.8-venv python3.8-dev python3-dev python3-pip python3-venv python3-wheel libpng-dev libfreetype6-dev libblas3 liblapack3 libblas-dev liblapack-dev pkg-config
    cd /INSTALLERS
    #git clone git@github.com:MASILab/DeepN4.git
    git clone https://praitayini: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@github.com/MASILab/DeepN4.git
    cd DeepN4
    mv src/* /src/
    cd /src
    python3.8 -m venv venv
    source venv/bin/activate
    pip install wheel==0.38.4
    pip install --upgrade setuptools
    pip install --upgrade pip
    pip install -r /INSTALLERS/DeepN4/venv/pip_install_deepn4.txt
    # pip install -r /extra/pip_install_deepn4.txt
    deactivate
    cd /
    mv /extra/checkpoint_epoch_264 /APPS/

    # Clean up

    rm -r /INSTALLERS

%environment

    # FreeSurfer
    export FREESURFER_HOME=/APPS/freesurfer
    source $FREESURFER_HOME/SetUpFreeSurfer.sh
    
    # CUDA
    export CPATH="/usr/local/cuda/include:$CPATH"
    export PATH="/usr/local/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
    export CUDA_HOME="/usr/local/cuda"

%runscript

    xvfb-run -a --server-num=$((65536+$$)) --server-args="-screen 0 1600x1280x24 -ac" bash /src/run_deepn4.sh /INPUTS /OUTPUTS "$@"

