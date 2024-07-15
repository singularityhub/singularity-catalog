Bootstrap: docker
From: continuumio/miniconda3

%post
    mkdir -p /opt/conda/config
    export CONDARC=/opt/conda/config/.condarc

    # Install Mamba
    conda install -c conda-forge mamba python=3.10

    # Install Snakemake
    mamba install -c bioconda -c conda-forge snakemake


    # configure strict channel priority
    conda config --set channel_priority strict
    conda init bash

    # Source the conda.sh script to ensure conda commands are available
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/profile
    echo "conda activate base" >>  /etc/profile


    # Create environments using snakemake
    . /opt/conda/etc/profile.d/conda.sh
    conda activate base
    # Verify that strict channel priority is set
    conda config --show | grep channel_priority

    cd /opt/pipeline
    # make dummy data so snakemake can create the environments
    mkdir -p /opt/pipeline/data
    touch /opt/pipeline/data/CEN6_ver_220406.fasta
    touch /opt/pipeline/data/input.fastqsanger.gz
    touch /opt/pipeline/data/chip.fastqsanger.gz

    snakemake --use-conda --conda-prefix /opt/conda/envs --conda-create-envs-only --conda-frontend mamba --cores 4

    # Clean up
    mamba clean --all

    # make root accessible for everyone
    chmod -R 777 /root

%files
    envs /opt/pipeline/envs
    Snakefile /opt/pipeline/Snakefile
    config.yaml /opt/pipeline/config.yaml
    run_pipeline.py /opt/pipeline/run_pipeline.py


%environment
    export PATH=/opt/conda/bin:$PATH
    export CONDA_ENVS_PATH=/opt/conda/envs
    export CONDA_PREFIX=/opt/conda
    export CONDARC=/opt/conda/config/.condarc
    export HOME=/root

%runscript
    # Navigate to the pipeline directory
    # set cache directory

    /opt/pipeline/run_pipeline.py "$@"