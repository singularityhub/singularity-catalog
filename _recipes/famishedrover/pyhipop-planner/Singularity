Bootstrap: docker
From: ubuntu

%files
    ## We copy the files belonging to the planner to a dedicated folder in the image.
	. /planner

%post

    ## The "%post"-part of this script is called after the container has
    ## been created with the "%setup"-part above and runs "inside the
    ## container". Most importantly, it is used to install dependencies
    ## and build the planner. Add all commands that have to be executed
    ## once before the planner runs in this part of the script.

    ## Install all necessary dependencies.
    apt-get update
    apt-get -y install git
    apt-get -y install python3
    apt-get -y install python3-pip

    ## go to directory and make the planner
    python3 -m pip install antlr4-python3-runtime
    python3 -m pip install jinja2
    python3 -m pip install networkx
    python3 -m pip install colorlog
    python3 -m pip install pydot
    python3 -m pip install sortedcontainers
    cd /planner
    git clone https://gitlab.com/oara-architecture/planning/pddl-python
    cd pddl-python
    python3 setup.py install
    cd /planner
    python3 setup.py install

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

    DOMAINFILE=$1
    PROBLEMFILE=$2
    PLANFILE=$3

    #OPTIONS="--plan depth --ol earliest"
    OPTIONS="--plan hadd-max --ol sorted --hadd hadd-reuse"
    
    python3 -m hipop $OPTIONS $DOMAINFILE $PROBLEMFILE 2>&1 | tee $PLANFILE


## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        pyHiPOP
Description Hierarchical Partial-Order Planning
Authors     Charles Lesire <charles.lesire@onera.fr> Alexandre Albore <alexandre.albore@onera.fr>
SupportsRecursion yes
SupportsPartialOrder yes
