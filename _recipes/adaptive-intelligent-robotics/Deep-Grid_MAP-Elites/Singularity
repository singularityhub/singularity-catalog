Bootstrap: library
From: airl_lab/default/airl_env:base_ci


%labels
    Author a.cully@imperial.ac.uk
    Version v0.0.1

%files
    ./resources/setup.sh /git/sferes2
    	
%post
  export LD_LIBRARY_PATH="/workspace/lib:$LD_LIBRARY_PATH"
   apt-get update
   apt-get install time
   DEBIAN_FRONTEND=noninteractive apt-get install -y  python3-matplotlib python3-numpy python3-tk python3-dev python3-pip
   rm -rf /var/lib/apt/lists/*

   pip3 install seaborn pandas python-gitlab tabulate

   cd /git/sferes2/exp/
   mkdir Deep-Grid_MAP-Elites
   
   cd /git/sferes2/exp/

   git clone https://github.com/adaptive-intelligent-robotics/Deep-Grid_MAP-Elites.git ./Deep-Grid_MAP-Elites
   
   cd ../
   ./setup.sh

%runscript
    echo "Please call one of the apps"



%apprun Truth_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --truth --fit_var 0.05 --desc_var 0.01  

%apprun Naive_1_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --naive --n_sampling 1 --fit_var 0.05 --desc_var 0.01  

%apprun Naive_50_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --naive --n_sampling 50 --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --adapt --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_BD_10_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --adapt_BD --adapt_depth 10 --fit_var 0.05 --desc_var 0.01  

%apprun Deep_50_arm_var
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_arm_var -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --deep --deep_depth 50 --fit_var 0.05 --desc_var 0.01  




%apprun Truth_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --truth --fit_var 0.05 --desc_var 0.01  

%apprun Naive_1_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --naive --n_sampling 1 --fit_var 0.05 --desc_var 0.01  

%apprun Naive_50_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --naive --n_sampling 50 --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --adapt --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_BD_10_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --adapt_BD --adapt_depth 10 --fit_var 0.05 --desc_var 0.01  

%apprun Deep_50_rastrigin
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_rastrigin -d $CURPATH/results/$PATHNAME -e -n 20000000 -p 500 --deep --deep_depth 50 --fit_var 0.05 --desc_var 0.01  



%apprun Truth_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --truth --n_sampling 1 --fit_var 0.05 --desc_var 0.01  

%apprun Naive_1_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --naive --n_sampling 1 --fit_var 0.05 --desc_var 0.01  

%apprun Naive_50_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --naive --n_sampling 50 --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --adapt --fit_var 0.05 --desc_var 0.01  

%apprun Adapt_BD_10_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --adapt_BD --adapt_depth 10 --fit_var 0.05 --desc_var 0.01  

%apprun Deep_50_hexa
    CURPATH=$(pwd)
    if [ ! -d ./results ]; then
        mkdir results
    fi
    cd /git/sferes2/
    PATHNAME=$(date +%Y-%m-%d_%H_%M_%S)_$$
    mkdir $CURPATH/results/$PATHNAME
    time build/exp/Deep-Grid_MAP-Elites/experiment_hexa_omni -d $CURPATH/results/$PATHNAME -e -n 5000000 -p 300 --deep --deep_depth 50 --fit_var 0.05 --desc_var 0.01  



%apprun Analysis
    cd /git/sferes2/
    python3 /git/sferes2/exp/Deep-Grid_MAP-Elites/analyse/main_analysis.py -d "$@"
    cd /git/sferes2/exp/Deep-Grid_MAP-Elites/
    python3 ./gitlab_notebook/gen_report.py "$@"


%apprun gen_job_scripts
    echo "Generating job scripts"
    python3 /git/sferes2/exp/Deep-Grid_MAP-Elites/gitlab_notebook/gen_job_script.py "$@"
	
    
%help
    Comparison of stochacity-handling schemes for MAP-Elites on three tasks
