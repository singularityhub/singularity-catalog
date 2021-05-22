Bootstrap: docker

From: continuumio/miniconda3

%files

%environment
    PATH=$PATH:/opt/conda/bin

%post
    apt-get update
    . /opt/conda/etc/profile.d/conda.sh
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda install -y  samtools==1.11
    conda install -y -c bioconda bowtie2
    conda install -y -c bioconda sortmerna
    conda install -y -c bioconda fastqc
    conda install -y -c bioconda fastq-screen
    conda install -y -c bioconda -c conda-forge multiqc
    conda install -y -c bioconda fastq-pair
    conda install -y -c bioconda kaiju
    conda update --all

%runscript
    exec "$@"
