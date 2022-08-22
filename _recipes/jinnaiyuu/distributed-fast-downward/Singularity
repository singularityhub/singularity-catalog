Bootstrap: docker
From: ubuntu

%setup
     ## The "%setup"-part of this script is called to bootstrap an empty
     ## container. It copies the source files from the branch of your
     ## repository where this file is located into the container to the
     ## directory "/planner". Do not change this part unless you know
     ## what you are doing and you are certain that you have to do so.

    REPO_ROOT=`dirname $SINGULARITY_BUILDDEF`
    cp -r $REPO_ROOT/ $SINGULARITY_ROOTFS/planner

%post

    ## The "%post"-part of this script is called after the container has
    ## been created with the "%setup"-part above and runs "inside the
    ## container". Most importantly, it is used to install dependencies
    ## and build the planner. Add all commands that have to be executed
    ## once before the planner runs in this part of the script.

    ## Install all necessary dependencies.
    apt-get update
    apt-get -y install cmake g++ make python g++-multilib build-essential libtool autoconf automake flex bison time ssh rsh-client rsh-server

    cd ./planner/

    ## Install openmpi-2.1.0
    cd ./library/
    tar -xvzf openmpi-2.1.0.tar.gz
    cd ./openmpi-2.1.0
    autoreconf -f -i
    ./configure CFLAGS=-m64 CXXFLAGS=-m64 
    make -j4
    make install
    cd ../../
    ldconfig
    
    echo "Testing if mpic++ is working..."
    which mpic++

    PATH=$PATH:/usr/local/bin
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

    # Build your planner
    cd ./src
    ./build_all

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    PATH=$PATH:/usr/local/bin
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

    ## Call your planner.
    /planner/src/plan \
        $DOMAINFILE \
        $PROBLEMFILE \
        --search "hdastar(lmcut,zobrist)" 2

# --plan-file $PLANFILE \

## TODO: dump the plan file 


## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        Distributed Fast Downward
Description GRAZHDA*: Hash Distirbuted A* with Efficient Work Distribution Method
Authors     Yuu Jinnai <ddyuudd@gmail.com>
SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no
