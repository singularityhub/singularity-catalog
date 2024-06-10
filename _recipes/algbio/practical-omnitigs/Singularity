Bootstrap: debootstrap
OSVersion: bionic
MirrorURL:  http://mirrors.nic.funet.fi/ubuntu/
Include: build-essential, git

%post
    echo "Downloading conda..."
    wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh -O anaconda.sh
    echo "Installing conda..."
    bash anaconda.sh -b -p /anaconda
    echo "Setting up conda for bash..."
    eval "$(/anaconda/bin/conda shell.bash hook)"
    conda init

    echo "Cloning practical-omnitigs..."
    cd /
    git clone https://github.com/algbio/practical-omnitigs
    cd practical-omnitigs
    mkdir -p data
    echo "Setting up practical-omnitigs conda environment..."
    conda env create -f environment.yml
    echo "Setting up snakemake conda environments..."
    snakemake --cores 1 --use-conda --conda-create-envs-only report_wtdbg2
    echo "Done!"

%runscript
    echo "Activating practical-omnitigs environment..."
    cd /practical-omnitigs
    source activate practical-omnitigs
    echo "Executing 'snakemake $*'"
    exec snakemake "$@"
