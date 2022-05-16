Bootstrap: docker

From: rocker/tidyverse:4.1.2

%post
  ## Updating...
  apt update --allow-releaseinfo-change 
  apt -y install wget python3-pip python2.7-dev libbz2-dev liblzma-dev libncurses5-dev poppler-utils


  ## Install htslib 1.9
  wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2
  tar -vxjf htslib-1.9.tar.bz2
  cd htslib-1.9
  ./configure
  make
  make install
  cd ..

  ## Install bcftools 1.9
  wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2
  tar -vxjf bcftools-1.9.tar.bz2
  cd bcftools-1.9
  ./configure
  make
  make install
  cd ..

  ## Install samtools 1.9
  wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
  tar -vxjf samtools-1.9.tar.bz2
  cd samtools-1.9
  ./configure
  make
  make install

  ## Export the paths
  export HTSLIB_LIBRARY_DIR=/usr/local/lib
  export HTSLIB_INCLUDE_DIR=/usr/local/include
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

  ## Installing R packages
  R -e "remotes::install_version('remotes')"
  R -e "remotes::install_version('BiocManager')"

  R -e "remotes::install_version('gridExtra', version='2.3', dependencies= T)"
  R -e "remotes::install_version('optparse', version='1.6.6', dependencies= T)"
  R -e "remotes::install_version('Canopy', version='1.3.0', dependencies= T)"
  R -e "remotes::install_version('jsonlite', version='1.6.1', dependencies= T)"
  R -e "remotes::install_version('vcfR', version='1.10.0', dependencies= T)"
  R -e "remotes::install_github('thomasp85/patchwork@v1.0.1')"
  R -e "BiocManager::install('GenomicRanges', version=3.14)"


  ###########################################################################
  ## Installing python2 packages
  wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
  python2 get-pip.py
  python2 -m pip install pysam==0.16.0.1 pytest==4.6.11 pypez==0.1.5 pandas==0.24.2 configargparse==0.14.0

  # commit: Add hgvsc_vep/hgvsp_vep to vepconsequencevariant
  pip install git+https://github.com/NagaComBio/BioMine.git@dca65800ef96accf361e5699c4dffa78d8d89938
  # Commit: hgvsc & hgvsp directly from VEP
  pip install git+https://github.com/NagaComBio/CharGer.git@421de97e3f383cef011c5107151bbbb4c6641e81

  python2 -m pip install matplotlib==1.4.3

  #########################################################################
  ## Installing cyvcf2 package
  pip3 install cython==0.29.24
  pip3 install cyvcf2==0.11.7

  ## Installing python3 packages
  pip3 install futures3==1.0.0
  pip3 install pandas==1.3.4
  pip3 install matplotlib==3.5.0
  pip3 install pytest==6.2.5

  ##########################################################################
  ## Downloading Clinvar parsing repo
  git clone https://github.com/NagaComBio/clinvar.git
  mkdir /src
  mv clinvar/src /src/clinvar_src
  rm -r clinvar
 
  wget -N https://raw.githubusercontent.com/ericminikel/minimal_representation/master/normalize.py -P /src/clinvar_src
  
  ##########################################################################
  ## Installing VT
  git clone https://github.com/atks/vt.git
  cd vt
  git submodule update --init --recursive
  make
  mv vt /usr/local/bin
  cd ..
  rm -r vt

%runscript

%startscript
