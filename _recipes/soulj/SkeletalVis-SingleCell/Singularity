Bootstrap: docker
From: rocker/tidyverse:4.1.1

%environment
PATH=$PATH:/opt/miniconda3/bin:/opt/bamtofastq
export PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export JAVA_LD_LIBRARY_PATH="${JAVA_HOME}"/jre/lib/amd64/server

%files
    ./install/* install/

%post
#install the common
apt-get update &&
apt-get -y install git bzip2 libglpk-dev libjpeg-dev libz-dev libxt-dev libtiff5-dev libbz2-dev jq aria2 xmlstarlet ncbi-tools-bin

#install bam2fastq
mkdir /opt/bamtofastq
wget https://github.com/10XGenomics/bamtofastq/releases/download/v1.4.0/bamtofastq_linux -O /opt/bamtofastq/bamtofastq
chmod 775 /opt/bamtofastq/bamtofastq
       
#install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
rm Miniconda3-latest-Linux-x86_64.sh

#set up conda to automatically activate when the singularity container is ran
sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT
echo "conda activate singlecell" >> $SINGULARITY_ENVIRONMENT

. /opt/miniconda3/etc/profile.d/conda.sh

#install the software via conda
conda config --add channels defaults
conda config --add channels conda-forge
conda create --name singlecell python=3.7
conda config --add channels bioconda
conda activate singlecell
conda install -c bioconda parallel-fastq-dump
conda install -c bioconda ffq
conda install -c bioconda entrez-direct
conda install -c bioconda multiqc
conda install -c bioconda fastqc
#resort using pip to avoid ngs-tools problem with bioconda kb
pip install kb-python --ignore-installed certifi

#install the R libraries needed
Rscript ./install/installRLibs.R
