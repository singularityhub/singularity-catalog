Bootstrap: shub
From: phgenomics-singularity/mlst:latest

%help
A Singularity image for MENINGOTYPE v0.8.2-beta

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
MENINGOTYPE version 0.8.2-beta
isPCR version 33
MLST version latest

%environment
export MENINGOTYPE_VERSION=0.8.2-beta
export PATH=/opt/conda/bin:$PATH
export PYTHONUSERBASE=False

%post
  export PATH=/opt/conda/bin:$PATH
  MENINGOTYPE_VERSION=0.8.2-beta
  isPCR_VERSION=33
  
  apt-get --yes update
  apt-get --yes install build-essential autoconf automake wget git zlib1g-dev libbz2-dev libncurses5-dev curl unzip

  apt-get --yes install software-properties-common
  
  # add python3 support
  conda install python==2.7.14

  echo "Installing isPCR"
  
  export MACHTYPE='unix'
  export OLDHOME=${HOME}
  isPCR_VERSION=33
  isPCR_DL="http://hgwdev.cse.ucsc.edu/~kent/src/isPcr${isPCR_VERSION}.zip"
  isPCR_ZIP=ispcr.zip
  wget -O ${isPCR_ZIP} "${isPCR_DL}"
  unzip -o ${isPCR_ZIP}
  cd isPcrSrc
  export HOME=${PWD}
  sed -i 's/-Werror//g' inc/common.mk
  mkdir -p bin/${MACHTYPE}
  mkdir -p lib/${MACHTYPE}  
  make
  mv bin/${MACHTYPE}/*Pcr /usr/local/bin
  cd ..
  rm -r isPcrSrc ${isPCR_ZIP}
  export HOME=${OLDHOME}
  
  
  echo "Installing MENINGOTYPE"

  MENINGOTYPE_GT="git+https://github.com/MDU-PHL/meningotype.git@v${MENINGOTYPE_VERSION}"
  pip install ${MENINGOTYPE_GT}
  
  echo "UPDATING MENINGOTYPE DB"
  meningotype --updatedb
  
  echo "Sorting some env variables..."
  echo "DB updated on $(date "+%Y-%m-%d")" > /etc/dbupdate
  chmod 555 /etc/dbupdate
  echo 'LANGUAGE="en_US:en"' >> $SINGULARITY_ENVIRONMENT
  echo 'LC_ALL="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT
  echo 'LC_CTYPE="UTF-8"' >> $SINGULARITY_ENVIRONMENT
  echo 'LANG="en_US.UTF-8"' >>  $SINGULARITY_ENVIRONMENT
  
  echo "Done"
  
%runscript
  echo "Welcome to MENINGOTYPE 0.8.2-beta" >&2
  cat /etc/dbupdate >&2
  exec meningotype "$@"

%test
  export PATH=/opt/conda/bin:$PATH
  echo "Testing MENINGOTYPE"
  meningotype --all --test
