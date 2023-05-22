Bootstrap: docker
From: nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

%labels
    AUTHOR FKS
    MAINTAINER fksato@mit.edu
    VERSION v1.0
    GUIDE "https://github.com/facebookresearch/VMZ/blob/master/tutorials/Installation_guide.md"

%setup
    # commands to be executed on host outside container during bootstrap

%post
    # Post setup, runs inside the image
    apt-get update && apt-get install -y apt-transport-https
    apt clean
    apt-get update
    apt-get upgrade -y

    apt-get install -y build-essential cmake pkg-config libatlas-base-dev gfortran unzip wget

    apt-get update -qq && apt-get -y install \
      autoconf \
      automake \
      git-core \
      libass-dev \
      libfreetype6-dev \
      libsdl2-dev \
      libtool \
      libva-dev \
      libvdpau-dev \
      libvorbis-dev \
      libxcb1-dev \
      libxcb-shm0-dev \
      libxcb-xfixes0-dev \
      pkg-config \
      texinfo

    # Nvidia driver mount paths (if GPU required)
    mkdir /nvlib /nvbin
    mkdir /cachedir /tempdir
    export SINGULARITY_CACHEDIR=/cachedir
    export TMPDIR=/tempdir

    #Add nvidia driver paths to the environment variables
    echo "\n #Nvidia driver paths \n" >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH="/nvbin"' >> $SINGULARITY_ENVIRONMENT
    echo 'export LD_LIBRARY_PATH="/nvlib"' >> $SINGULARITY_ENVIRONMENT

    #Add CUDA paths
    echo "\n #Cuda paths \n" >> /environment
    echo 'export CPATH="/usr/local/cuda/include"' >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> $SINGULARITY_ENVIRONMENT
    echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> $SINGULARITY_ENVIRONMENT
    echo 'export CUDA_HOME="/usr/local/cuda"' >> $SINGULARITY_ENVIRONMENT

    ## OpenMPI
    echo "Installing Open MPI"
    export OMPI_DIR=/opt/ompi
    export OMPI_VERSION=3.1.0
    export OMPI_URL="https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-$OMPI_VERSION.tar.bz2"
    mkdir -p $TMPDIR/ompi
    # Download
    cd $TMPDIR/ompi && wget -O openmpi-$OMPI_VERSION.tar.bz2 $OMPI_URL && tar -xjf openmpi-$OMPI_VERSION.tar.bz2
    # Compile and install
    cd /tmp/ompi/openmpi-$OMPI_VERSION && ./configure --prefix=$OMPI_DIR --with-cuda=/usr/local/cuda && \
    make -j8 install
    ldconfig
    # Set env variables so we can compile our application
    echo "export PATH=$OMPI_DIR/bin:$PATH" >> $SINGULARITY_ENVIRONMENT
    echo "export LD_LIBRARY_PATH=$OMPI_DIR/lib:$LD_LIBRARY_PATH" >> $SINGULARITY_ENVIRONMENT
    echo "export MANPATH=$OMPI_DIR/share/man:$MANPATH" >> $SINGULARITY_ENVIRONMENT

    ## cleanup
    apt-get clean
    apt-get autoremove

    ## Python3.6, venv, numpy
    apt-get install -y yasm libx264-dev
    apt-get install -y software-properties-common
    add-apt-repository ppa:deadsnakes/ppa
    apt-get update
    apt-get install -y python3-pip python3.6-dev python3.6-venv

    cd /usr/local
    python3.6 -m venv main_env
    . /usr/local/main_env/bin/activate
    echo '. /usr/local/main_env/bin/activate' >> $SINGULARITY_ENVIRONMENT

    pip install --upgrade pip
    pip install numpy

    apt-get clean
    apt-get autoremove

    #### OpenCV binaries ###
    # needed for c headers #
    ########################
    mkdir -p $TMPDIR/opencv
    cd $TMPDIR/opencv
    wget https://github.com/opencv/opencv/archive/4.1.1.zip -O opencv-4.1.1.zip
    unzip opencv-4.1.1.zip
    cd  opencv-4.1.1
    mkdir build && cd build

    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D PYTHON_EXECUTABLE=/usr/local/main_env/bin/python3.6 \
        -D BUILD_EXAMPLES=ON \
        -D BUILD_SHARED_LIBS=ON ..
    make -j8
    make install
    ldconfig

    ln -s /usr/local/lib/python3.6/site-packages/cv2 /usr/local/main_env/lib/python3.6/site-packages

    ## nasm, ffmpeg
    mkdir -p $TMPDIR/nasm $TMPDIR/ffmpeg_src

    cd $TMPDIR/nasm && \
    wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2 && \
    tar xjvf nasm-2.13.03.tar.bz2 && \
    cd nasm-2.13.03 && \
    ./autogen.sh && \
    PATH="/usr/local/bin:$PATH" ./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin" && \
    make && make install

    cd $TMPDIR/ffmpeg_src && \
    wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
    tar xjvf ffmpeg-snapshot.tar.bz2 && \
    cd ffmpeg && \
    PATH="/usr/local/bin:$PATH" PKG_CONFIG_PATH="/usr/local/ffmpeg_build/lib/pkgconfig" ./configure \
      --prefix="/usr/local/ffmpeg_build" \
      --pkg-config-flags="--static" \
      --extra-cflags="-I/usr/local/ffmpeg_build/include" \
      --extra-ldflags="-L/usr/local/ffmpeg_build/lib" \
      --extra-libs="-lpthread -lm" \
      --bindir="/usr/local/bin" \
      --enable-gpl \
      --enable-libvorbis \
      --enable-libx264 \
      --enable-nonfree     
    make -j8
    make install

    echo "export PATH=/usr/local/bin:$PATH" >> $SINGULARITY_ENVIRONMENT
    echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> $SINGULARITY_ENVIRONMENT
    echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH" >> $SINGULARITY_ENVIRONMENT
    hash -r 
    ldconfig

    ## Caffe2 Deps
    apt-get install -y \
      libgoogle-glog-dev \
      libgtest-dev \
      libiomp-dev \
      libleveldb-dev \
      liblmdb-dev \
      libopencv-dev \
      libopenmpi-dev \
      libsnappy-dev \
      libprotobuf-dev \
      protobuf-compiler \
      libgflags-dev

    . $SINGULARITY_ENVIRONMENT

    pip install lmdb flask future graphviz hypothesis jupyter matplotlib protobuf pydot python-nvd3 pyyaml \
        requests scikit-image scipy six tornado pandas scikit-learn h5py

    pip install git+https://github.com/brain-score/brainio_base
    
    cd /usr/local
    git clone --recursive https://github.com/pytorch/pytorch.git
    cd pytorch && git submodule update --init

    rm -r $TMPDIR/*
    TORCH_CUDA_ARCH_LIST="5.2;6.0;6.1;7.0" USE_OPENCV=1 USE_FFMPEG=1 USE_LMDB=1 python setup.py install

    ## Python 3.6.9 compatible VMZ ##
    cd /usr/local
    git clone https://github.com/fksato/VMZ.git

    # Default mount paths
    mkdir /scratch /data /shared /fastdata

%environment
    export SINGULARITY_CACHEDIR=/cachedir
    export TMPDIR=/tempdir
    export OMPI_DIR=/opt/ompi
    export SINGULARITY_OMPI_DIR=$OMPI_DIR
    export SINGULARITYENV_APPEND_PATH=$OMPI_DIR/bin
    export SINGULAIRTYENV_APPEND_LD_LIBRARY_PATH=$OMPI_DIR/lib

    export PYTHONPATH=/usr/local/pytorch/build:/usr/local/VMZ/lib
    #Add nvidia driver paths to the environment variables (if GPU required)
    # export PATH="/nvbin:$PATH"
    # export LD_LIBRARY_PATH="/nvlib:$LD_LIBRARY_PATH"

%runscript
    #Runs inside the image every time it starts up

%test
    . /usr/local/main_env/bin/activate
    if python --version | grep 'Python 3.6.9' > /dev/null; then \
      echo $(python -c 'import cv2; print(f"CV2 version: {cv2.__version__}")'); \
    else echo "$(python --version)"; fi
    ffmpeg -version
