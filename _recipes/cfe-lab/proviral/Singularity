# Generate the Singularity container to run PrimerFinder on Kive.
Bootstrap: docker
From: ubuntu:22.04

%help
    Search proviral consensus sequences for primers, then use CFEIntact to
    decide if the genomes are complete.

    This Singularity container can be run on Kive: http://cfe-lab.github.io/Kive


%labels
    MAINTAINER BC CfE in HIV/AIDS https://github.com/cfe-lab/
    KIVE_INPUTS sample_info_csv contigs_csv conseqs_csv cascade_csv
    KIVE_OUTPUTS outcome_summary_csv conseqs_primers_csv contigs_primers_csv \
        table_precursor_csv proviral_landscape_csv detailed_results_tar
    KIVE_THREADS 1
    KIVE_MEMORY 6000

%files
    setup.py /opt/cfeproviral/
    cfeproviral /opt/cfeproviral/
    scripts /opt/cfeproviral/

%post
    sh -- /opt/cfeproviral/scripts/install.sh

%environment
    export LANG=en_US.UTF-8

%runscript
    cd -- /w
    cfeproviral sample --cfeintact "$@"
