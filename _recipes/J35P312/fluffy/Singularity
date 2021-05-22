Bootstrap: docker
From: ubuntu:16.04

%environment
SHELL=/bin/bash
PATH=/opt/anaconda/bin:${PATH}
LC_ALL=C.UTF-8

%runscript
    export PATH=/opt/anaconda/bin:${PATH}    

%post
    apt-get update
    apt-get -y install wget git bzip2 build-essential gcc zlib1g-dev language-pack-en-base apt-transport-https make cmake unzip sudo libatlas3-base python3 python3-pip
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

    cd /root/ && wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && chmod 700 ./Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && bash ./Miniconda2-latest-Linux-x86_64.sh -b -p /opt/anaconda/

    export PATH=/opt/anaconda/bin:${PATH}

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    conda config --add channels r

    #conda install -c bioconda wisecondorx=1.1.5
    pip install -U git+https://github.com/CenterForMedicalGeneticsGhent/WisecondorX@v1.1.6

    conda install -c bioconda samtools picard bioconductor-dnacopy
    conda install -c bioconda bwa fastqc biobambam
    conda install -c r r-doparallel r-foreach r-neuralnet r-glmnet r-data.table r-mass r-matrix r-jsonlite

    pip install sklearn numpy scipy matplotlib pysam futures bottleneck cython
    pip3 install multiqc
    
    cd /bin/ && wget https://github.com/CenterForMedicalGeneticsGhent/PREFACE/archive/v0.1.1.zip && unzip v0.1.1.zip
    cd /
    
    cd /bin/ && git clone https://github.com/J35P312/AMYCNE.git && cd AMYCNE && python setup.py build_ext --inplace    
    
    git clone https://github.com/SciLifeLab/TIDDIT.git
    mv TIDDIT/* /bin/
    cd /bin/ && ./INSTALL.sh
    chmod +x /bin/TIDDIT.py

   cd /bin/ && git clone https://github.com/J35P312/FluFFyPipe.git

