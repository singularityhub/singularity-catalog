Bootstrap: docker

From: continuumio/miniconda3

%files

%environment
    PATH=$PATH:/opt/conda/bin:/Graphbin:/MetaBMF

%post
    apt-get update
    . /opt/conda/etc/profile.d/conda.sh
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda install -y  samtools==1.11
    conda install -y -c bioconda bowtie2
    conda install -y -c bioconda megahit
    conda install -y -c bioconda metabat2
    conda install -y -c bioconda checkm-genome
    conda install -y -c bioconda concoct
    conda install -y -c AgBiome bbtools
    conda install -y -c conda-forge python-igraph
    conda install -y -c conda-forge biopython
    conda install -y -c conda-forge cairocffi
    conda update --all

    git clone https://github.com/Vini2/GraphBin.git
    chmod 755 /GraphBin/graphbin
    git clone https://github.com/didi10384/MetaBMF
    chmod 755 /MetaBMF/MetaBMF.sh

%runscript
    exec "$@"
