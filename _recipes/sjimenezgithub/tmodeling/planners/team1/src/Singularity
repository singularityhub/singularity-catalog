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
    apt-get -y install cmake g++ g++-multilib make python scons

    ## Build Universal PDDL Parser
    cd /planner/universal-pddl-parser
    scons
    
    ## Build Temporal Planning Repository
    cd /planner/temporal-planning
    scons
    cd fd_copy
    ./build.py release64 -j4

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    ## Call your planner.
    /planner/temporal-planning/bin/plan_portfolio.py --no-iterated --time 1680 --memory 6000 --use-full-time --plan-file $PLANFILE $DOMAINFILE $PROBLEMFILE

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        CP4TP
Description Portfolio planner that calls sequentially (until a solution is found): a sequential planner, TP-SHE, TP-[2,3,4] and STP-[2,3,4].
Authors     Anders Jonsson <anders.jonsson@upf.edu> and Daniel Furelos-Blanco <daniel.furelos@upf.edu>
