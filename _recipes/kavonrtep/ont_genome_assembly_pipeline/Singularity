Bootstrap: docker
From: continuumio/miniconda3@sha256:3a2017213a16daff5bc8dec8571354249c3370d6b0d64ac78e8538257ce42d4c

%post
    apt-get update
    apt-get install -y libxml2 libxml2-dev file coinor-cbc
    # install build tools, zlib, and git
    apt-get install -y build-essential zlib1g-dev git
    apt-get install -y default-jre
    mkdir -p /opt/conda/config
    export CONDARC=/opt/conda/config/.condarc
    touch /opt/conda/config/.condarc
    # Install Mamba
    conda install -c conda-forge mamba

    # Install Snakemake
    mamba install -c bioconda -c conda-forge snakemake coin-or-cbc=2.10.10

    # test if cbc is correctly installed, if not exit with error
    cbc ? || exit 1


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
    # Dummy data for snakemake

    touch /opt/pipeline/data/read_all_sample.fastq
    touch /opt/pipeline/data/P.fulvum_MW160430.1_plast.fasta
    touch /opt/pipeline/data/Pisum_fulvum_NC_059792.1_min.fasta
    touch /opt/pipeline/data/FabTR_all_sequences_231010.db.RM_format
    touch /opt/pipeline/data/Cameor_v2_release_2_chromosomes_only.fasta_all.NGSfilter_CamIllumina.selected.CLEAN.fasta
    touch /opt/pipeline/data/JI1006_fulvum_v2.1.fasta.fai
    touch /opt/pipeline/data/JI1006_v2.1_x_oligos_CAMv2r2.blast_out

    # this creates the conda environments but does not run the pipeline
    snakemake --use-conda --conda-prefix /opt/conda/envs --conda-create-envs-only --cores 4 --configfile /opt/pipeline/config.yaml

    # use config/ opt/pipeline/envs/pysam.yaml to create the pysam environment
    mamba env create -f /opt/pipeline/envs/pysam.yaml

    # Clean up
    mamba clean --all

    # make root accessible for everyone
    chmod -R 777 /root
    # remove all temp files

    # install hifiasm
    cd /opt
    git clone https://github.com/chhylp123/hifiasm
    cd hifiasm && make
    cp hifiasm /usr/local/bin

    # install dorado
    cd /opt
    wget https://cdn.oxfordnanoportal.com/software/analysis/dorado-0.9.1-linux-x64.tar.gz
    tar -xvf dorado-0.9.1-linux-x64.tar.gz
    ln -s /opt/dorado-0.9.1-linux-x64/bin/dorado /usr/local/bin/dorado
    rm dorado-0.9.1-linux-x64.tar.gz

%files
    envs /opt/pipeline/envs
    Snakefile /opt/pipeline/Snakefile
    config_template.yaml /opt/pipeline/config.yaml
    run_pipeline.py /opt/pipeline/run_pipeline.py
    scripts /opt/pipeline/scripts
    gepard-1.30 /opt/gepard-1.30



%environment
    export PATH=/opt/pipeline/scripts:/opt/conda/bin:$PATH
    export CONDA_ENVS_PATH=/opt/conda/envs
    export CONDA_PREFIX=/opt/conda
    export CONDARC=/opt/conda/config/.condarc
    export HOME=/root
    export GEPARD=/opt/gepard-1.30


%runscript
    # Navigate to the pipeline directory
    # set cache directory

    /opt/pipeline/run_pipeline.py "$@"