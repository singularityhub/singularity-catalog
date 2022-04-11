Bootstrap: docker
From: ubuntu:18.04

%environment
    export INSTALLDIR=/opt/h5plot
    export PATH=$INSTALLDIR:$PATH

%post
    export INSTALLDIR=/opt/h5plot
    mkdir -p $INSTALLDIR && cd $INSTALLDIR

    apt-get update
    apt-get install -y git python3-pip
    apt-get install -y libgl1-mesa-glx qt5-default

    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade https://github.com/revoltek/losoto/archive/master.zip
    python3 -m pip install lofar-h5plot

%runscript
    export INSTALLDIR=/opt/h5plot
    export PATH=$INSTALLDIR:$PATH
    alias python='python3'
    h5plot "$@"

%help
    This Singularity image contains lofar-h5plot (https://github.com/tikk3r/lofar-h5plot).
