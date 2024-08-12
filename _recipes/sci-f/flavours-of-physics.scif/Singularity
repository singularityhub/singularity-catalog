BootStrap: docker
From: continuumio/anaconda3

%runscript

     # This will generate the scientific result!
     /opt/conda/bin/python /code/main.py


%labels
CONTAINERSFTW_TEMPLATE ubuntu16.04-python2
CONTAINERSFTW_COMPETITION_HOST containersftw
CONTAINERSFTW_COMPETITION_NAME ""

%environment
CONTAINERSFTW_DATA=/data/input
CONTAINERSFTW_RESULT=/code/results
CONTAINERSFTW_WORK=/code/analysis
export CONTAINERSFTW_DATA
export CONTAINERSFTW_RESULT
export CONTAINERSFTW_WORK

%setup

     # Data directories
     mkdir -p $SINGULARITY_ROOTFS/data/input   # data included with container
     mkdir -p $SINGULARITY_ROOTFS/data/work    # working directory
     mkdir -p $SINGULARITY_ROOTFS/data/mnt     # mounted datasets

     # Result directories
     mkdir -p $SINGULARITY_ROOTFS/code/results/submission
     mkdir -p $SINGULARITY_ROOTFS/code/results/web
     mkdir -p $SINGULARITY_ROOTFS/code/results/pub

     # Working code directories
     mkdir -p $SINGULARITY_ROOTFS/code

     /bin/bash functions/download_data.sh


%post

     apt-get update && apt-get install -y git vim nginx
     /opt/conda/bin/conda install -y numpy scikit-learn pandas 
     
     #########################################################
     # Install additional software / libraries here
     #########################################################


     #########################################################

     apt-get autoremove -y
     apt-get clean
