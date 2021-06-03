Bootstrap: docker
From: ubuntu:xenial

%setup
    ## The setup script is called bootstrap an empty container.
    ## This script runs outside of the container's context, so it can
    ## be used to access local files. Everything else should be done in
    ## the "%post"-script.

    REPO_ROOT=`dirname $SINGULARITY_BUILDDEF`
    mkdir -p $SINGULARITY_ROOTFS/planning
    cp -r $REPO_ROOT/ $SINGULARITY_ROOTFS/planning/fs-planner

%post
    ##### INSTALLATION DEPENDENCIES #####
    ## Install all necessary dependencies
    # We install only those boost packages that required by the project to reduce the size of the image.
    apt-get update && apt-get install --no-install-recommends -y \
            build-essential \
            pkg-config \
            g++ \
            python3 python3-pyparsing \
            git \
            scons \
            openssh-client \
            curl \
            less \
            gdb \
            ca-certificates \
            libboost-program-options-dev libboost-filesystem-dev libboost-system-dev \
            libboost-chrono-dev libboost-timer-dev libboost-serialization-dev \
            && rm -rf /var/lib/apt/lists/*

    ##### CLINGO INSTALLATION #####
    ## At the moment we simply download the 64-bit binaries and create and appropriate
    ## link to them which will be used afterwards as part of an environment variable
    cd /planning
    curl -SL http://github.com/potassco/clingo/releases/download/v5.2.2/clingo-5.2.2-linux-x86_64.tar.gz | tar xz \
        && ln -s clingo-5.2.2-linux-x86_64 clingo


    ##### GECODE INSTALLATION #####
    ## We install from source rather than use the package to minimize the bloat,
    ## since the official package installs by default all Gecode modules, including visualization tools, etc.
    ## We configure the build with only the strictly required modules
    cd /tmp
    curl -SL http://www.gecode.org/download/gecode-5.1.0.tar.gz | tar xz \
        && cd gecode-5.1.0 \
        && ./configure \
        --disable-minimodel \
        --disable-examples \
        --disable-flatzinc \
        --disable-gist \
        --disable-driver \
        --disable-qt \
        --disable-mpfr \
        --disable-doc-tagfile \
        --disable-doc-dot \
        --disable-thread \
        && make -j4 && make install


    ##### PLANNER INSTALLATION #####
    ## Compile the planner
    cd /planning/fs-planner
    git submodule update --init
    python ./build.py -p
    
%environment
    ## Set the appropriate library path for Gecode to be found
    LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
    GRINGO_PATH=/planning/clingo

    
%runscript
    ## Set the appropriate library path for Gecode to be found
    export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
    export GRINGO_PATH=/planning/clingo

    DOMAINFILE=`pwd`/$1
    PROBLEMFILE=`pwd`/$2
    PLANFILE=`pwd`/$3
    WORKSPACE=~/workspace
    
    mkdir -p ${WORKSPACE}

    /planning/fs-planner/run.py --asp -i ${PROBLEMFILE} --domain ${DOMAINFILE} \
               --planfile ${PLANFILE} \
               --driver sbfws --options "successor_generation=adaptive,evaluator_t=adaptive,bfws.rs=sim" \
               --workspace ${WORKSPACE}


%labels
## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
Name        FS Planner
Description TODO
Authors     Guillem Francès <guillem.frances@unibas.ch>
SupportsDerivedPredicates yes
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no
