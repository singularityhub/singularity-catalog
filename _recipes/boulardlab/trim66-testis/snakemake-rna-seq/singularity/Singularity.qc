Bootstrap: docker
From: alpine:3.12

%labels
MAINTAINER francesco.tabaro@embl.it
VERSION 1.0

%post
  apk update
  apk add bash clang openblas lapack gcc gfortran musl-dev freetype-dev \
    python3 python3-dev py-pip py3-kiwisolver py3-pillow py3-matplotlib \
    py3-wheel autoconf automake make openjdk8 perl fontconfig ttf-dejavu \
    pigz cython libtool nasm yasm-dev git
  pip install cutadapt 
  
  mkdir /install_src

  cd /install_src
  git clone https://github.com/ewels/MultiQC.git
  cd MultiQC
  python3 setup.py install
  
  cd /install_src
  wget -P /opt https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
  unzip -d /opt/ /opt/fastqc_v0.11.9.zip
  chmod 755 /opt/FastQC/fastqc
  ln -s /opt/FastQC/fastqc /usr/local/bin/
   
   cd /install_src
   wget -O trim_galore.tar.gz https://github.com/FelixKrueger/TrimGalore/archive/0.6.6.tar.gz &&
   tar xf trim_galore.tar.gz && \
   cp TrimGalore-0.6.6/trim_galore /usr/local/bin && \
   rm -r TrimGalore-0.6.6
   rm *.tar.gz


######################
## MULTIQC
######################

%apphelp multiqc
  MultiQC v1.10.1 - https://multiqc.info/docs/

%apprun multiqc
  exec multiqc


######################
## FASTQC
######################

%apphelp fastqc
  FastQC v0.11.9 - https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/

%apprun fastqc
  exec fastqc

######################
## TRIM_GALORE!
######################

%apphelp trim_galore
    TrimGalore v0.6.6 - https://github.com/FelixKrueger/TrimGalore

%apprun trim_galore
   exec trim_galore

