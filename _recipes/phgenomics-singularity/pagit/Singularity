Bootstrap: docker
From: ubuntu:trusty-20170817

%help
A Singulairty image for PAGIT

%labels
Maintainer Anders Goncalves da Silva
Build 1.0

%environment
PAGIT_VERSION=1.64bit
export PAGIT_VERSION

%post
    PAGIT_VERSION=1.64bit

    sudo locale-gen en_US.UTF-8
    sudo update-locale

    sudo apt-get --yes update
    sudo apt-get --yes install make wget tar tcsh openjdk-7-jre

    echo "INSTALLING PAGIT"
    INSTALLER=PAGIT.V${PAGIT_VERSION}.tgz
    wget ftp://ftp.sanger.ac.uk/pub/resources/software/pagit/${INSTALLER}
    mv ${INSTALLER} /opt && cd /opt
    tar zxf ${INSTALLER}
    sudo bash ./installme.sh
    rm -f ${INSTALLER}
    # comment out part of the test run that we don't want to run
    sudo sed -r -i 's/(^act.*)/#\1/g' PAGIT/exampleTestset/dotestrun.sh

    echo "Sorting some env variables..."
    sudo echo 'LANGUAGE="en_US:en"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LC_ALL="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LC_CTYPE="UTF-8"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LANG="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT

    # FIXING THE PATH
    sudo echo 'PAGIT_HOME=/opt/PAGIT' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'PATH=$PAGIT_HOME/bin/:$PAGIT_HOME/bin/pileup_v0.5/:$PAGIT_HOME/bin/pileup_v0.5/ssaha2:$PAGIT_HOME/bin/pileup_v0.5/:$PAGIT_HOME/IMAGE/:$PAGIT_HOME/ABACAS:$PAGIT_HOME/ICORN/:$PAGIT_HOME/RATT/:$PATH' >> $SINGULARITY_ENVIRONMENT
    # ABACAS and IMAGE just need a path to there position
    # icorn setup
    sudo echo 'PILEUP_HOME=$PAGIT_HOME/bin/pileup_v0.5/'>> $SINGULARITY_ENVIRONMENT
    sudo echo 'ICORN_HOME=$PAGIT_HOME/ICORN/' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'SNPOMATIC_HOME=$PAGIT_HOME/bin/' >> $SINGULARITY_ENVIRONMENT

    # RATT setup
    sudo echo 'RATT_HOME=$PAGIT_HOME/RATT' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'RATT_CONFIG=$RATT_HOME/RATT.config' >> $SINGULARITY_ENVIRONMENT

    # PERL SETUP
    sudo echo 'PERL5LIB=$PERL5LIB:$PAGIT_HOME/lib' >> $SINGULARITY_ENVIRONMENT

    sudo echo 'export PATH PILEUP_HOME ICORN_HOME PILEUP_HOME SNPOMATIC_HOME RATT_HOME RATT_CONFIG PERL5LIB PAGIT_HOME' >> $SINGULARITY_ENVIRONMENT

%runscript
  echo "Welcome to PAGIT ${PAGIT_VERSION}" >&2
  exec "$@"

%test
  echo "Loading the environment"
  for script in /.singularity.d/env/*.sh; do
      if [ -f "$script" ]; then
          . "$script"
      fi
  done
  echo "Testing PAGIT"
  mkdir /tmp/test && cp /opt/PAGIT/exampleTestset/* /tmp/test
  cd /tmp/test
  ./dotestrun.sh
  cd .. && rm -rf test
