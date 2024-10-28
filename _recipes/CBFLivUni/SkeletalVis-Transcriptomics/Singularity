Bootstrap: docker
From: rocker/tidyverse:4.1.1

%environment
PATH=$PATH:/opt/miniconda3/bin
export PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export JAVA_LD_LIBRARY_PATH="${JAVA_HOME}"/jre/lib/amd64/server

%files
    ./install/* install/

%post
apt-get update &&
apt-get -y install git bzip2 libglpk-dev libjpeg-dev libz-dev libxt-dev libtiff5-dev libbz2-dev

        
#install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
rm Miniconda3-latest-Linux-x86_64.sh

#automatically activate the conda enviroment when the container starts
sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT
echo "conda activate skeletalvis" >> $SINGULARITY_ENVIRONMENT

. /opt/miniconda3/etc/profile.d/conda.sh


#install the software via conda
conda config --add channels defaults
conda config --add channels conda-forge
conda create --name skeletalvis python=3.9
conda activate skeletalvis
conda config --add channels bioconda
conda install -c bioconda multiqc=1.12
conda install -c bioconda sra-tools=2.11.0
conda install -c bioconda fastqc=0.11.9
conda install -c bioconda parallel-fastq-dump=0.6.7
conda install -c bioconda kallisto=0.48.0
conda install -c bioconda fastq-screen=0.14.0
conda install -c bioconda hisat2=2.2.1
conda install -c bioconda samtools=1.15.1
conda install -c bioconda fastp=0.23.2
conda install -c bioconda trimmomatic=0.39

#install the R libraries needed
Rscript ./install/installRLibs.R

#install aspera
wget https://download.asperasoft.com/download/sw/ascp-client/3.5.4/ascp-install-3.5.4.102989-linux-64.sh -P /opt
chmod +x /opt/ascp-install-3.5.4.102989-linux-64.sh
./opt/ascp-install-3.5.4.102989-linux-64.sh
rm /opt/ascp-install-3.5.4.102989-linux-64.sh

#clean up
rm *.txt *.csv *.sqlite *.soft.gz

