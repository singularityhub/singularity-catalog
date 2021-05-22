Bootstrap: docker
From: ubuntu:bionic

%post
    ## Install all necessary dependencies.
    apt-get update
    apt-get -y install cmake g++ make python ca-certificates git
    rm -rf /var/lib/apt/lists/*

    git clone -b ipc-2018-seq-sat https://bitbucket.org/ipc2018-classical/team45.git /planner

    ## Build planner.
    cd /planner
    ./build.py release64

    ## Build h2-mutexes preprocessor.
    mkdir -p builds/h2-mutexes/
    cd builds/h2-mutexes/
    cmake ../../h2-mutexes/
    make -j4

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    ## Call your planner.
    /planner/fast-downward.py \
        --build=release64 \
        --plan-file $PLANFILE \
        --transform-task /planner/builds/h2-mutexes/bin/preprocess \
        --alias seq-sat-fdss-2018 \
        $DOMAINFILE \
        $PROBLEMFILE

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        Fast Downward Stone Soup 2018
Description portfolio of satisficing Fast Downward configurations
Authors     Jendrik Seipp <jendrik.seipp@unibas.ch> and Gabriele Röger <gabriele.roeger@unibas.ch>
SupportsDerivedPredicates yes
SupportsQuantifiedPreconditions yes
SupportsQuantifiedEffects yes
