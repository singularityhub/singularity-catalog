Bootstrap:docker  
From:continuumio/anaconda

%labels
    MAINTAINER Marc Hoeppner <m.hoeppner@ikmb.uni-kiel.de>
    DESCRIPTION Singularity image containing all requirements for the wgs pipeline
    VERSION 1.0

%environment
    PATH=/opt/conda/envs/wgs-calling-1.0/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a

# Prereqs for Nextflow
apt-get -y install procps 

# Create mount point for RZCluster
mkdir -p /ifs
