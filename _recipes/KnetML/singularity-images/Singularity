Bootstrap: docker
From: ubuntu:latest

%environment
   
   LANG=C.UTF-8
   LC_ALL=C.UTF-8
   export LANG LC_ALL
   export LD_LIBRARY_PATH=/usr/lib:/usr/lib64:/usr/local/cuda/lib64:/usr/local/cuda/lib:/opt/cudnn/lib64:$LD_LIBRARY_PATH
   export PATH=/opt/julia-0.6/bin:/usr/local/cuda/bin:$PATH
   export JULIA_PKGDIR=/workdir/.julia
   export XDG_RUNTIME_DIR="/workdir/notebooks"
   export JUPYTER=/usr/local/bin/jupyter
   export JUPYTER_PATH=/workdir/.jupyter
   export JUPYTER_DATA_DIR=/workdir/.jupyter

%runscript
exec jupyter notebook --notebook-dir=/workdir/notebooks --ip='*' --port=8888 --no-browser

%post
 
   echo "Here we are installing software and other dependencies for the container!"
   apt-get update
   apt-get install -y \
    build-essential \
    libzmq3-dev \
    pkg-config \
    python \
    python-dev \
    python-pip \
    git \
    vim \
    emacs \
    libxml2 \
    wget \
    curl \
    unzip \
    cmake \
    hdf5-tools \

    pip install jupyter
    
    mkdir -p /opt/julia-0.6.2-dev && \
    curl -s -L https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.2-linux-x86_64.tar.gz | tar -C /opt/julia-0.6.2-dev -x -z --strip-components=1 -f -
    ln -fs /opt/julia-0.6.2-dev/bin/julia /usr/bin/julia
    
    export JULIA_PKGDIR=/workdir/.julia
    
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.init()'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("CUDAapi")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("Knet")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("JLD")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("ArgParse")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("PyCall")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("Images")'

    export JUPYTER=/usr/local/bin/jupyter
    export JUPYTER_PATH=/workdir/.jupyter
    export JUPYTER_DATA_DIR=/workdir/.jupyter
    
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.add("IJulia")'
    /opt/julia-0.6.2-dev/bin/julia -e 'Pkg.build("IJulia")'

    rm -rf /workdir/.julia/.cache
    rm -rf /workdir/.julia/lib

    mkdir -p /workdir/notebooks

    chmod -R 777 /workdir

    mkdir -p /opt/cudnn
    mkdir -p /usr/local/cuda
