Bootstrap: docker
From: continuumio/miniconda3

%post
    mkdir -p /opt/conda/config
    export CONDARC=/opt/conda/config/.condarc

    # Install Mamba
    conda install -c conda-forge mamba python=3.11

    # Install Snakemake
    mamba install -c bioconda -c conda-forge snakemake=8.12.0
    mamba install h5py
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
    touch /opt/pipeline/data/CEN6_ver_220406_part.fasta
    touch /opt/pipeline/data/pisum_custom_library.fasta
    touch /opt/pipeline/data/FabTR_all_sequences_210901.db.RM_format.fasta

    snakemake --use-conda --conda-prefix /opt/conda/envs --conda-create-envs-only --conda-frontend mamba --cores 4 --configfile /opt/pipeline/config.yaml

    # Clean up
    mamba clean --all

    # make root accessible for everyone
    chmod -R 777 /root
    # remove all temp files

%files
    envs /opt/pipeline/envs
    Snakefile /opt/pipeline/Snakefile
    config.yaml /opt/pipeline/config.yaml
    data/rdna_library.fasta /opt/pipeline/data/rdna_library.fasta
    run_pipeline.py /opt/pipeline/run_pipeline.py
    scripts /opt/pipeline/scripts


%environment
    export PATH=/opt/pipeline/scripts:/opt/conda/bin:$PATH
    export CONDA_ENVS_PATH=/opt/conda/envs
    export CONDA_PREFIX=/opt/conda
    export CONDARC=/opt/conda/config/.condarc
    export HOME=/root


%runscript
    # Navigate to the pipeline directory
    # set cache directory

    /opt/pipeline/run_pipeline.py "$@"