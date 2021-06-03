Bootstrap: debootstrap 
OSVersion: bionic
MirrorURL: http://uk.archive.ubuntu.com/ubuntu/ 

%help
   Image to allow builds of SETC software in https://github.research.its.qmul.ac.uk/btx188/SETC

%post
   apt-get update && apt install -y software-properties-common
   add-apt-repository universe
   apt-get update && apt install -y \
      cmake \
      g++ \
      pkg-config \
      libgsl-dev \
      libboost-dev \
      libboost-filesystem-dev \
      libboost-system-dev \
      libsundials-dev \
      libarmadillo-dev \
      libopenblas-dev \
      openssh-server \
      autoconf \
      build-essential \
      wget 
   # cleanup to reduce overall size
   apt clean && rm -rf /var/lib/apt/lists/*
   # Install OpenMPI
   mkdir -p /opt/build && cd /opt/build
   wget https://download.open-mpi.org/release/open-mpi/v3.0/openmpi-3.0.0.tar.gz
   tar -xvf openmpi-3.0.0.tar.gz
   rm openmpi-3.0.0.tar.gz
   cd openmpi-3.0.0

   ./configure --with-sge
   make
   make all install

   # Update libraries
   ldconfig

   # Build an MPI test and cleanup
   /usr/local/bin/mpicc examples/ring_c.c -o /usr/bin/mpi_ring

   cd ..
   rm -r openmpi-3.0.0

%test
    export PATH=/usr/local/bin:$PATH
    # Test MPI
    mpirun --allow-run-as-root /usr/bin/mpi_ring
