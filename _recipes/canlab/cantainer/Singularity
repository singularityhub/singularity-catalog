# FMRIPREP from poldracklab

BootStrap: docker
From: poldracklab/fmriprep:latest

%runscript
    exec /usr/local/miniconda/bin/fmriprep "$@"


%post
    #------------------------------------------------------------------------------
    # Fix possible permission issue
    #------------------------------------------------------------------------------
    chmod -R a+rX /usr/local/miniconda
    chmod +x /usr/local/miniconda/bin/*

    #------------------------------------------------------------------------------
    # Create directories to enable access to common HPCC mount points, like blanca
    #------------------------------------------------------------------------------
    mkdir /work