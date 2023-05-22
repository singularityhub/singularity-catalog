BootStrap: docker
From: slayerchen/eih_staging:latest

%help
    This is a Singularity container for EIH simulations.
    It builds a minimal Python 3 environment running on Linux with all the libraries required for EIH simulations.

%labels
    Maintainer Chen Chen (chenchen.bme@gmail.com)
    Version v0.4
   
%environment
     conda=/opt/conda/bin/conda
     pip=/opt/conda/bin/pip
     python3=/opt/conda/bin/python
     python=python3
     export conda pip python3 python

%post 
     # create bind points for HPCC environment
     mkdir -p /EIH

%test  
     echo "Testing python..."
     /opt/conda/bin/python -V
