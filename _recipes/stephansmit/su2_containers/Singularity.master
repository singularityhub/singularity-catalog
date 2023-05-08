Bootstrap: docker
From: ubuntu:16.04
  
%post
    echo "Update apt-get"
    apt-get -y update

    echo "Install python3 and MPI"
    apt-get -y install python3 git build-essential autoconf python-dev libopenmpi-dev openmpi-common openmpi-bin

    echo "Install requirements for infiniband on surfsara"
    apt-get install -y dkms infiniband-diags libibverbs* ibacm librdmacm* libmlx4* libmlx5* mstflint libibcm.* libibmad.* libibumad* opensm srptools rdmacm-utils ibverbs-utils perftest vlan ibutils 

    echo "Clone the current master branch of SU2"
    git clone --depth=1 https://github.com/su2code/SU2

    echo "Install SU2"
    cd SU2
    autoreconf -i
    export CXXFLAGS="-O3"
    python3 preconfigure.py --enable-mpi --prefix=$PWD
    make install -j 7

    echo "Clean all the compiling objects"
    make clean
 
%runscript
     exec /SU2/bin/$1 $2   
