Bootstrap:docker  
From:nfcore/base

%labels
    MAINTAINER Marc Hoeppner <m.hoeppner@ikmb.uni-kiel.de>
    DESCRIPTION Singularity image containing all requirements for the annotation pipeline
    VERSION 0.1

%environment
    PATH=/opt/conda/envs/genome-annotation-1.0/bin:/opt/conda/envs/genome-annotation-1.0/opt/pasa-2.3.3/bin:/opt/bin:$PATH
    export PATH

    PERL5LIB=$PERL5LIB:/usr/local/share/perl/5.24.1
    export PERL5LIB

    PASAHOME=/opt/conda/envs/genome-annotation-1.0/opt/pasa-2.3.3
    export PASAHOME

    EVM_HOME=/opt/conda/envs/genome-annotation-1.0/opt/evidencemodeler-1.1.1
    export EVM_HOME

%files
    environment.yml /

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a

# Prereqs for Nextflow
apt-get -y install procps make gcc

cpan -i URI::Encode
# Create mount point for RZCluster
mkdir -p /ifs

# Create the default config file
cp /opt/conda/envs/genome-annotation-1.0/opt/pasa-2.3.3/pasa_conf/pasa.CONFIG.template /opt/conda/envs/genome-annotation-1.0/opt/pasa-2.3.3/pasa_conf/conf.txt

# Install rapid fasta splitter
mkdir -p /opt/bin && cd /opt/bin && wget ftp://saf.bio.caltech.edu/pub/software/molbio/fastasplitn.c && gcc -o fastasplitn fastasplitn.c && chmod +x fastasplitn

