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
    cmake-gui \
    xorg-dev \
    libglu1-mesa-dev \ 
    mesa-utils \
    libboost-all-dev \
    libgl1-mesa-glx \
    libsm6 \
    libxext6 \
    libcairo2 \
    python3-pip \
    python3 \
    python3-tk \
    python3-pil.imagetk \
    python-cairo \
    freeglut3-dev \
    freeglut3 \
    libopengl0 -y \
    mesa-common-dev \
    software-properties-common \
    nano
    
    
    
  python3 -m pip install dask 
  python3 -m pip install dask distributed --upgrade
  
  pip3 install open3d
  
  #pip3 install --upgrade pip 
  
  pip3 install --upgrade pip setuptools wheel
  
  #pip3 install numpy --upgrade --ignore-installed
    
  pip3 install  numpy \
                Pillow \
                rdp \
                scipy \
                scikit-image==0.19.3 \
                scikit-learn \
                scikit-build \
                matplotlib \
                mahotas \
                numexpr \
                plyfile \
                psutil \
                cairosvg \
                certifi \
                pandas \
                pytest \
                coverage \
                coveralls \
                open3d \
                opencv-python \
                openpyxl \
                click \
                PyYAML \
                imutils 
  
  mkdir /lscratch /db /work /scratch
  
  chmod -R a+rwx /opt/code/
  
  
  pip3 install --upgrade numpy

  apt-key adv --keyserver keys.openpgp.org --recv-key 612DEFB798507F25

  add-apt-repository 'deb [ arch=amd64 ] https://downloads.skewed.de/apt focal main'

  apt update 

  apt install python3-graph-tool -y

  chmod +x /opt/3D_model_traits_demo/shim.sh 
  
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
   
