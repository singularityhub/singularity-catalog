Bootstrap: docker
From: ubuntu:xenial

%post
    ## Install all necessary dependencies.
    apt-get update
    apt-get -y install cmake g++ make python autotools-dev automake gcc g++-multilib ca-certificates git
    rm -rf /var/lib/apt/lists/*

    git clone -b ipc-2018-seq-opt https://bitbucket.org/ipc2018-classical/symbolic-baseline-planners.git /planner

    ## Build your planner
    cd /planner
    ./build.py release64 -j6

%runscript
    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    ## Call your planner.
    /planner/fast-downward.py \
        --build=release64 \
        --plan-file $PLANFILE \
        $DOMAINFILE \
        $PROBLEMFILE \
        --search "sbd()"


%labels
Name        Baseline: symbolic-bidirectional
Description Symbolic bidirectional uniform cost search
SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects yes
