
Bootstrap: docker
From: nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

%environment

  PATH=/opt/conda/bin:$PATH
  export PATH
  
%post
  
    # Update list of packages
    apt-get update
    # Install dependencies
    apt-get install -y --no-install-recommends build-essential cmake git curl vim ca-certificates libjpeg-dev libpng-dev
    # Clean up
    rm -rf /var/lib/apt/lists/*
    
    # Install miniconda
    cd /opt
    curl -o /opt/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x /opt/miniconda.sh
    /opt/miniconda.sh -b -p /opt/conda 
    rm /opt/miniconda.sh
    /opt/conda/bin/conda install numpy pyyaml scipy ipython mkl mkl-include
    /opt/conda/bin/conda install -c soumith magma-cuda90
    /opt/conda/bin/conda clean -ya
    
    # Install the released version of Pytorch.
    /opt/conda/bin/conda install pytorch torchvision cuda90 -c pytorch

    echo 'export PATH=/opt/conda/bin:$PATH' >>$SINGULARITY_ENVIRONMENT
    
    
