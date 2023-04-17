BootStrap: docker
From: ubuntu:18.04

%labels
  Maintainer: Suxing Liu
  Version v1.01

%setup
  #----------------------------------------------------------------------
  # commands to be executed on host outside container during bootstrap
  #----------------------------------------------------------------------
  mkdir ${SINGULARITY_ROOTFS}/opt/code/

%files
  ./* /opt/code/

%post
  #----------------------------------------------------------
  # Install common dependencies and create default entrypoint,
  # commands to be executed inside container during bootstrap
  #----------------------------------------------------------
  # Install dependencies
  apt update
  
  apt-get install -y tzdata 
  
 apt install -y \
    build-essential \
    python3-setuptools \
    python3-pip \
    python3-tk \
    python3-numexpr \
    python3-pil.imagetk \
    python3-sklearn \
    python3-sklearn-lib \
    tzdata \
    libgl1-mesa-glx \
    libsm6 \
    libxext6
    

  pip3 install open3d
  
  #pip3 install --upgrade pip 
  
  pip3 install --upgrade pip setuptools wheel
  
  #pip3 install numpy --upgrade --ignore-installed
  
  pip3 install  cmake \
                rdp \
                pandas \
                scipy \
                scikit-image \
                matplotlib \
                networkx \
                plyfile \
                opencv-python \
                openpyxl \
                numpy --upgrade --ignore-installed
  
  
  mkdir /lscratch /db /work /scratch
  
  chmod -R a+rwx /opt/code/
  
%environment
  #----------------------------------------------------------
  # Setup environment variables
  #----------------------------------------------------------
  PYTHONPATH=$PYTHONPATH:/opt/code/
  export PATH
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/code/
  export LD_LIBRARY_PATH

%runscript
  #----------------------------------------------------------
  # Run scripts inside container
  #----------------------------------------------------------
   # commands to be executed when the container runs
   echo "Arguments received: $*"
   exec /usr/bin/python "$@"
  
%test
  #----------------------------------------------------------
  # commands to be executed within container at close of bootstrap process
  #----------------------------------------------------------
   python3 --version
   #python3 requirement.py 
   
