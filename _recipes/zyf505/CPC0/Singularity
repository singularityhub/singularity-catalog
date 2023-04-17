Bootstrap: docker
From: ubuntu:xenial

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
    apt-get -y install cmake g++ make python autotools-dev automake gcc g++-multilib

    ## Build your planner
    cd /planner
    ./build.py release64 -j6

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3
    BOUND=$4

    ## Call your planner.
    /planner/fast-downward.py \
        --build=release64 \
        --plan-file $PLANFILE \
        $DOMAINFILE \
        $PROBLEMFILE \
	--search "astar(modular_pdb(modular_rbp(time_limit=200),rand_walk_evaluator_avg_h(time_limit=30),1080,pdb_factory=modular_symbolic))"
	##--search "lazy_greedy_admiss_cost_bounded(modular_pdb(modular_rbp(time_limit=200),rand_walk(time_limit=10),900,pdb_factory=modular_symbolic,create_perimeter=true),reopen_closed=true,bound=$4,cost_type=NORMAL)"
## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        Complementary0
Description  Modified version of complementary heuristic, where we are using completely new bin packing algorithms(paper pending), in situ learning of all the algorithm parameters critical to the pattern selection performance (previously only which pattern generation algorithm we use).  Also we have added a new pattern generator inspired on how Gamer chooses a single PDB which it keeps improving.  Also the selection algorithm is based on size of search space (previously selection criteria was time).  Some features from previous complementary heuristic as in the iJCAI 18 paper are yet to be adapted to this version, e.g. mutation for local search of succesful selection, stratified sampling. 
Authors Santiago Franco<santiago.franco@gmail.com>, Levi H S Lelis<levilelis@gmail.com>, Mike W Barley<m.barley@auckland.ac.nz>,Stefan Edelkamp<stefan.edelkamp@kcl.ac.uk>, Moises Martinez<moises.martinez@kcl.ac.uk>, Ionut Moraru <ionut.moraru@kcl.ac.uk>, Yufeng Zou <yzou854@aucklanduni.ac.nz>
SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects yes
