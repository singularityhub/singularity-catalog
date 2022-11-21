Bootstrap: docker
From: ubuntu:xenial

%post
    ## Install all necessary dependencies.
    apt update
    apt -y install ca-certificates cmake gawk git g++ g++-multilib make python python-dev python-pip
    rm -rf /var/lib/apt/lists/*

    ## Get the sources and install pip dependencies.
    git clone https://github.com/JesseBrouw/Thesis.git /planner
    cd /planner
    pip install -r requirements.txt

    ## Build your planner
    cd /planner
    ./build.py release64 -j4
    cd /planner/symba
    ./build -j4

    ## Clean up
    mkdir -p /compiled-planner/builds/release64
    mv /planner/driver /compiled-planner
    mv /planner/symba /planner/symba.py /compiled-planner
    mv /planner/fast-downward.py /planner/plan-ipc.py /planner/create-image-from-graph.py /planner/timers.py /compiled-planner
    mv /planner/dl_model /compiled-planner
    rm -rf /compiled-planner/dl_model/model_creation /compiled-planner/dl_model/model.h5 /compiled-planner/dl_model/model.json
    mv /planner/builds/release64/bin /compiled-planner/builds/release64
    mkdir -p /compiled-planner/src
    mv /planner/src/translate/ /compiled-planner/src/
    rm -rf /third-party
    rm -rf /planner
    mv /compiled-planner /planner
    apt-get -y autoremove cmake g++ make


%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    ## Call your planner.
    /planner/plan-ipc.py \
        $DOMAINFILE \
        $PROBLEMFILE \
        $PLANFILE \
        --image-from-lifted-task
    
    ## Call your planner.
    /planner/plan-ipc.py \
        $DOMAINFILE \
        $PROBLEMFILE \
        $PLANFILE \
        --image-from-grounded-task

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        Delfi1
Description This planner uses an offline learned algorithm selector to choose the "best" planner online based on a abstract structure graph of the PDDL description of the planning task. In particular, the learning algorithm uses such graphs of a planning task, turns them into an image and uses the planner runtime to train a neural net. The learned model thus predicts runtime of planners on a given task and chooses a planner accordingly.
Authors     Michael Katz <michael.katz1@ibm.com>, Shirin Sohrabi <ssohrab@us.ibm.com>, Horst Samulowitz <samulowitz@us.ibm.com>, and Silvan Sievers <silvan.sievers@unibas.ch>
SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no