Bootstrap: docker
From: ubuntu

%setup
  cp -r opt ${SINGULARITY_ROOTFS}/
  cp Simulation1.jar ${SINGULARITY_ROOTFS}/
  cp singscript.sh ${SINGULARITY_ROOTFS}/

%post
  mkdir /output
  apt-get update
  apt-get install -y default-jre
  apt-get install -y default-jdk
  apt-get install -y build-essential
  apt-get install -y wget git
  wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh
  bash anaconda.sh -b -p /opt/anaconda
  bash singscript.sh

%environment
  export PATH="/opt/anaconda/bin:$PATH"
  export CPLEX_PATH="/opt/ibm/ILOG/CPLEX_Studio1271/cplex/bin/x86-64_linux"
  export RUN_OUTPUT="/output/"
