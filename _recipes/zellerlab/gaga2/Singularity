Bootstrap: docker
From: ubuntu:18.04
IncludeCmd: yes

%environment
R_VERSION=4.1
export R_VERSION
R_CONFIG_DIR=/etc/R/
export R_CONFIG_DIR
export LC_ALL=C
export PATH=/opt/software/miniconda3/bin:$PATH

%post
  apt-get update
  apt-get install -y apt-transport-https apt-utils software-properties-common
  apt-get install -y add-apt-key
  export DEBIAN_FRONTEND=noninteractive
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
  apt-get install -y tzdata
  dpkg-reconfigure --frontend noninteractive tzdata

  #add CRAN/Ubuntu repo, add key, then refresh
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
  apt-get update

  apt-get install -y wget python3-pip git nano libblas3 libblas-dev liblapack-dev liblapack3 curl gcc fort77 aptitude g++ xorg-dev libreadline-dev gfortran libssl-dev libxml2-dev libpcre3-dev liblzma-dev libbz2-dev libcurl4-openssl-dev libhdf5-dev hdf5-helpers libmariadb-client-lgpl-dev
#  gfortran --version
 
  wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
  bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/software/miniconda3
  rm -f Miniconda3-latest-Linux-x86_64.sh

  /opt/software/miniconda3/bin/conda install -y -c conda-forge -c bioconda bbmap seqtk fastqc multiqc 

  git clone https://github.com/cschu/figaro.git  # Zymo-Research repo does not yet allow 0 length primers
  cd figaro
  git checkout feature/single_end_support
  python3 setup.py bdist_wheel
  pip3 install --force-reinstall dist/*.whl

  cd /opt/software
  wget -q https://github.com/jfmrod/MAPseq/releases/download/2.0.1alpha/mapseq-2.0.1alpha-linux.tar.gz
  tar xzf mapseq-2.0.1alpha-linux.tar.gz
  rm mapseq-2.0.1alpha-linux.tar.gz
  mv mapseq-2.0.1alpha-linux mapseq

  ln -s /opt/software/mapseq/mapseq /usr/bin/
  ln -s /opt/software/mapseq/share /usr/bin/









  apt-get install -y r-base r-base-dev
  R --version
  
  # installing packages from cran
  R --slave -e 'install.packages(c("devtools", "tidyverse", "cowplot"),repos="https://cran.rstudio.com/")'

  # installing from bioc
  R --slave -e 'if (!requireNamespace("BiocManager",quietly=TRUE)) install.packages("BiocManager")'
  R --slave -e 'BiocManager::install(version = "3.13", ask = FALSE)'
  R --slave -e 'BiocManager::install(c("dada2"))'
