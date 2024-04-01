# Generate the Singularity container to run PrimerFinder on Kive.
Bootstrap: docker
From: ubuntu:22.04

%help
    Search proviral consensus sequences for primers, then use HIVSeqinR to
    decide if the genomes are complete.

    This Singularity container can be run on Kive: http://cfe-lab.github.io/Kive


%labels
    MAINTAINER BC CfE in HIV/AIDS https://github.com/cfe-lab/
    KIVE_INPUTS sample_info_csv contigs_csv conseqs_csv cascade_csv
    KIVE_OUTPUTS outcome_summary_csv conseqs_primers_csv contigs_primers_csv \
        table_precursor_csv proviral_landscape_csv hivseqinr_results_tar
    KIVE_THREADS 1
    KIVE_MEMORY 6000

%files
    setup.py /opt/primer_finder/
    gene_splicer /opt/primer_finder/

%post
    echo ===== Installing Prerequisites ===== >/dev/null
    apt-get update
    apt-get install -y build-essential unzip git wget \
        fontconfig libbz2-dev liblzma-dev libssl-dev \
        libffi-dev libsqlite3-dev

    echo ===== Installing Python ===== >/dev/null
    apt-get install -y python3 python3-pip

    echo ===== Installing blast ===== >/dev/null
    apt-get install -y ncbi-blast+

    echo ===== Installing Python packages ===== >/dev/null
    cd /opt/primer_finder
    pip3 install .

    echo ===== Installing minimap2 ===== >/dev/null
    apt-get install -y minimap2

    echo ===== Installing hivseqinr ===== >/dev/null
    apt-get install -y libz-dev libcurl4-openssl-dev libxml2-dev
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y r-base
    Rscript /opt/primer_finder/gene_splicer/configure_r.sh
    python3 -m gene_splicer.hivseqinr /opt/hivseqinr

    # Clean up
    apt-get remove -y wget git build-essential
    apt-get clean
    rm -rf /var/lib/apt/lists/*

%environment
    export LANG=en_US.UTF-8

%runscript
    gene_splicer_sample --hivseqinr /opt/hivseqinr "$@"
