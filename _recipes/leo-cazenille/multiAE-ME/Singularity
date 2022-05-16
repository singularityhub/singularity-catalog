Bootstrap: docker
From: lcazenille/multiae


%labels
    Author leo.cazenille@gmail.com
    Version 0.1.0

%environment
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

%post
    pip3 uninstall -y qdpy
#    pip3 uninstall -y tqdm
    pip3 install tqdm sklearn tabulate
    pip3 install --upgrade --no-dependencies --no-cache-dir git+https://gitlab.com/leo.cazenille/qdpy.git@develop scoop pyzmq greenlet

%runscript
    echo "Nothing there yet..."

%apprun main
    exec ./scripts/main.py $@

%apprun scoop_main
    exec python3 -m scoop ./scripts/main.py $@

%apprun several_main
    nb_runs=$1
    config=$2
    shift; shift;
    exp_name=`echo $config | sed 's/.yaml$//'`
    mkdir results/$exp_name
    for i in $(seq 1 $nb_runs); do
        sleep 10
        logname=$(date +%Y%m%d%H%M%S).log
        ./scripts/main.py -c conf/$config $@ 2>&1 | tee results/$exp_name/$logname
    done

%apprun parallel_main
    nb_runs=$1
    config=$2
    shift; shift;
    exp_name=`echo $config | sed 's/.yaml$//'`
    mkdir results/$exp_name
    for i in $(seq 1 $nb_runs); do
        sleep 10
        logname=$(date +%Y%m%d%H%M%S).log
        ./scripts/main.py -c conf/$config $@ 2>&1 > results/$exp_name/$logname &
    done
    wait


%apprun stats
    exec ./scripts/stats.py $@

