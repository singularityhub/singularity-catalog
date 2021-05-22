Bootstrap: docker
From: ubuntu:20.04

%runscript
    echo "The runscript is the containers default runtime command!"
    # home is "/root" and this is the cwd

    # these are now bound and pulled from outside
    #cd /matt/mlib
    #git reset --hard #undo chmod so can pull
    #git pull
    #cd /matt/dnn
    #git reset --hard #undo chmod so can pull
    #git pull


    cd /matt

    # Not sure why I felt te need to do this each time. They are hardly ever updated.
    #echo copy1
    #cp -r _resources/_weights dnn
    #echo copy2
    #cp -r _ImageNetTesting dnn
    #echo copy3
    #cp -r _data dnn

    cd dnn

    env
    # bash
    # CONDA_HOME=/matt/miniconda3

    echo "CONDA_HOME in singularity runscript is:"$CONDA_HOME
    ./dnn "$@"
    #exec bash
    exec echo "exec in the runscript replaces the current process!"

%labels
   AUTHOR mjgroth@mit.edu

%post
    echo "The post section is where you can install, and configure your container."
apt update

    apt full-upgrade -y
    apt autoremove
    apt install curl -y
    apt install libgl1-mesa-glx -y #https://github.com/conda-forge/pygridgen-feedstock/issues/10
    cd /
    mkdir matt
    cd matt
    curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x miniconda.sh
    ./miniconda.sh -b -p miniconda3
    rm miniconda.sh










apt install git -y
    git clone https://github.com/mgroth0/dnn
    git clone https://github.com/mgroth0/mlib
    /matt/miniconda3/bin/conda update -n base -c defaults conda
    /matt/miniconda3/bin/conda create -y --name dnn python=3.8
    /matt/miniconda3/bin/conda config --add channels conda-forge
    /matt/miniconda3/bin/conda config --add channels mgroth0
    cd dnn

    # https://dev.to/setevoy/docker-configure-tzdata-and-timezone-during-build-20bk
    export TZ=America/New_York
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone




    /matt/miniconda3/bin/conda install -y -n dnn graphviz
    /matt/miniconda3/bin/conda install -y -n dnn pydot
    /matt/miniconda3/bin/conda install -y -n dnn yapf
    /matt/miniconda3/bin/conda install -y -n dnn matplotlib
    /matt/miniconda3/bin/conda install -y -n dnn scipy
    /matt/miniconda3/bin/conda install -y -n dnn aiohttp



    /matt/miniconda3/bin/conda install -y -n dnn bs4
    /matt/miniconda3/bin/conda install -y -n dnn colorama
    /matt/miniconda3/bin/conda install -y -n dnn gitpython
    /matt/miniconda3/bin/conda install -y -n dnn htmlmin
    /matt/miniconda3/bin/conda install -y -n dnn imageio
    /matt/miniconda3/bin/conda install -y -n dnn lesscpy
    /matt/miniconda3/bin/conda install -y -n dnn onnx



    /matt/miniconda3/bin/conda install -y -n dnn opencv
    #/matt/miniconda3/bin/conda install -y -n dnn packaging






    #/matt/miniconda3/bin/conda install -y -n dnn pandas
    #/matt/miniconda3/bin/conda install -y -n dnn pexpect
    #/matt/miniconda3/bin/conda install -y -n dnn pybtex
    #/matt/miniconda3/bin/conda install -y -n dnn pycallgraph
    #/matt/miniconda3/bin/conda install -y -n dnn pygments
    #/matt/miniconda3/bin/conda install -y -n dnn pyqt
    #/matt/miniconda3/bin/conda install -y -n dnn scikit-learn
    #/matt/miniconda3/bin/conda install -y -n dnn texttable
    #/matt/miniconda3/bin/conda install -y -n dnn wolframclient
    #/matt/miniconda3/bin/conda install -y -n dnn websockets
    #/matt/miniconda3/bin/conda install -y -n dnn dateparser
    #/matt/miniconda3/bin/conda install -y -n dnn xerox
    #/matt/miniconda3/bin/conda install -y -n dnn tensorflow-datasets






    echo "done with post-build"