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
    apt-get -y install cmake g++ make python autotools-dev automake gcc g++-multilib

    ## Build your planner
    cd /planner
    ./build.py release64 -j7

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
        $DOMAINFILE \
        $PROBLEMFILE \
        --search "astar(blind())"

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        Complementary
Description PDB heuristic which learns in situ how to adapt its pattern selection parameteres to maximize chance of finding "good" patterns as seach progresses and also complements any input heuristic.
Authors     
SupportsDerivedPredicates yes
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no
