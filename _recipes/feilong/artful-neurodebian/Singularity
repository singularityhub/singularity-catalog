BootStrap: debootstrap
OSVersion: artful
MirrorURL: http://us.archive.ubuntu.com/ubuntu/


%runscript
    /bin/bash


%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update

    # apt-get install -y --no-install-recommends apt-utils
    apt-get install -y --no-install-recommends wget tree emacs-nox
    apt-get install -y --no-install-recommends locales tzdata
    locale-gen en_US en_US.UTF-8
    update-locale LANG=en_US.UTF-8
    echo "US/Eastern" | tee /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata

    apt-get install -y --no-install-recommends gnupg dirmngr

    # NeuroDebian
    wget -O- http://neuro.debian.net/lists/artful.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9

    apt-get update

    mkdir -p /scratch /local-scratch /fastscratch /ihome /idata
    chmod a+rX /scratch /local-scratch /fastscratch /ihome /idata

    apt-get install -y --no-install-recommends \
        python python-numpy python-scipy python-matplotlib ipython \
        python-pandas python-sympy python-nose python-nibabel \
        python3 python3-numpy python3-scipy python3-matplotlib ipython3 \
        python3-pandas python3-sympy python3-nose python3-nibabel \
        jupyter-notebook python-future python3-future

    apt-get install -y \
        git git-annex datalad python-datalad \
        connectome-workbench ants \
        python-dicom dcm2niix

    apt-get install -y --no-install-recommends \
        python-h5py python3-h5py \
        python-seaborn python3-seaborn \
        python-joblib python3-joblib \
        python-psutil python3-psutil \
        python-tables python3-tables \
        python-mpi4py python3-mpi4py \
        python-pip python3-pip \
        python-setuptools python3-setuptools \
        python-wheel python3-wheel \
        python-vtk6 \
        python-shogun \
        python-statsmodels \
        python-mvpa2 python-mvpa2-lib \
        python-surfer \
        python-nitime \
        python3-distributed \
        python3-dask

        # python-nilearn python3-nilearn \

    apt-get install -y --no-install-recommends gcc python-dev python3-dev
    pip install dask distributed pprocess
    pip3 install pprocess

    wget -O- http://neuro.debian.net/lists/zesty.us-nh.full >> /etc/apt/sources.list.d/neurodebian.sources.list
    cp /etc/apt/sources.list /etc/apt/sources.list.backup
    echo "deb http://us.archive.ubuntu.com/ubuntu zesty main universe" >> /etc/apt/sources.list
    apt-get update
    apt-get install -y --no-install-recommends python-sklearn python3-sklearn \
        python-sklearn-lib python3-sklearn-lib python-pymc python-nipy
    apt-get install -y afni fsl-complete heudiconv convert3d

    apt-get purge -y --auto-remove gnupg dirmngr
    # apt-get purge -y --auto-remove gcc python-dev
    # apt-get clean
    # rm -rf /var/lib/apt/lists/*

    # wget https://raw.githubusercontent.com/feilong/PyMVPA/efa20a58a98270df2a222dc14dbf77e7b3d162b1/mvpa2/algorithms/hyperalignment.py -O /usr/lib/python2.7/dist-packages/mvpa2/algorithms/hyperalignment.py

    mkdir /apps && chmod a+rX /apps

    cd /apps
    curl ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz | tar xvz
