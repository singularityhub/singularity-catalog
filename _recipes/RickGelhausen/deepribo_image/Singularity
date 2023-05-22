Bootstrap: docker
From: ubuntu:bionic

%environment
    ## ensure deepribo env is in the path variable
    PATH="/home/miniconda3/envs/deepribo/bin:$PATH"

%files
    ## fetch deepribo dependencies
    deepribo.yaml

%post
    ## install wget and unzip
    apt-get update && apt-get install -y wget && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

    ## install conda
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/miniconda.sh
    bash /home/miniconda.sh -b -p /home/miniconda3
    rm /home/miniconda.sh
    export PATH="/home/miniconda3/bin:${PATH}"

    ## update conda
    conda --version
    conda update -n base -c defaults conda
    conda --version

    ## create conda env and ensure that it runs on startup
    conda env create --file deepribo.yaml
    echo "source activate deepribo" > ~/.bashrc
    export PATH="/home/miniconda3/envs/deepribo/bin:$PATH"

    ## install r
    conda install -c conda-forge r-base r-sizer r-optparse

    ## download DeepRibo
    wget https://github.com/Biobix/DeepRibo/archive/master.zip
    unzip master.zip -d /home && rm master.zip

    ## add shebang and fix minor issues with DeepRibo
    sed -i '1 i\#!/usr/bin/env python' /home/DeepRibo-master/src/*.py
    sed -i '1 i\#!/usr/bin/env Rscript' /home/DeepRibo-master/src/*.R
    sed -i 's/model.load_state_dict(torch.load(model_name, map_location=device))/model.load_state_dict(torch.load(model_name, map_location=device),strict=False)/g' /home/DeepRibo-master/src/DeepRibo.py
    sed -i 's/sys.exit(ParseArgs())/ParseArgs()/g' /home/DeepRibo-master/src/DeepRibo.py

    ## cleaning up
    cp /home/DeepRibo-master/src/*.py /usr/local/bin && cp /home/DeepRibo-master/src/*.R /usr/local/bin && rm -rf /home/DeepRibo-master/

    ## make files executable
    chmod +x /usr/local/bin/DataParser.py
    chmod +x /usr/local/bin/DeepRibo.py
    chmod +x /usr/local/bin/PredictToBedgraph.py
    chmod +x /usr/local/bin/s_curve_cutoff_estimation.R

    ## test deepribo commands
    DeepRibo.py -h
    DataParser.py -h
    PredictToBedgraph.py -h
    s_curve_cutoff_estimation.R

%runscript
    exec "$@"
