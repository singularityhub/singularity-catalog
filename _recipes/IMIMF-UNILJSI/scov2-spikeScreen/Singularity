BootStrap: docker
From: andersenlabapps/ivar:1.3.1

%labels
  Maintained by tomaz-mark.zorec@mf.uni-lj.si.  

%post
  apt-get update
  apt-get install -y wget \
                     vim \
                     gawk \
                     unzip \
                     curl \
                     libncurses5-dev \
                     zlib1g-dev \
                     libbz2-dev \
                     liblzma-dev \
                     mafft \
                     bwa \
                     bowtie2 \
                     trimmomatic \
                     fastqc \
                     seqtk 


  apt-get install --fix-missing -y
  
  cd /tmp
  wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
  sh Anaconda3-2020.11-Linux-x86_64.sh -b -p /opt/anaconda3

  export PATH=/opt/anaconda3/bin:$PATH

  conda update -y -n base -c defaults conda
  conda update -y conda 

  conda config --add channels bioconda 
  conda config --add channels conda-forge


  conda create -y -n bioinfo \
                     scipy=1.5.3 \
                     biopython=1.78 \
                     seqtk=1.3 \
                     seqkit=0.15.0 \
                     samtools=1.9 \
                     bwa=0.7.17 \
                     bcftools=1.9 \
                     bowtie2=2.3.4.1 \
                     mafft=7.475 \
                     trimmomatic=0.36 \
                     numpy=1.19.5 \
                     matplotlib=3.3.3 \
                     pandas=1.1.5 \
                     openpyxl=3.0.6 \
                     pilon=1.23 \
                     snpeff=5.0 \
                     bbmap
  # mountpoint
  mkdir /opt/scripts

%environment
  export PATH=/opt/anaconda3/bin:$PATH
  export PATH=/opt/anaconda3/envs/bioinfo/bin:$PATH