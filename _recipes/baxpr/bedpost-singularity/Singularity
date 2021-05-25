Bootstrap: docker
From: ubuntu:20.04

%help

  Runs FSL's bedpost on outputs of dtiQA_v7. See /opt/README.md


%files

  src        /opt
  README.md  /opt
  

%post

  apt-get update > /dev/null 2>&1
  apt-get install -y wget unzip zip xvfb ghostscript imagemagick bc > /dev/null 2>&1   # Misc tools
  apt-get install -y libopenblas-base language-pack-en              > /dev/null 2>&1   # FSL

  # Install python3 with pip and use by default
  # https://stackoverflow.com/a/61878185
  apt install -y python3 python3-pip python-is-python3
  pip3 install pandas nilearn nibabel

  # FSL. See https://fsl.fmrib.ox.ac.uk/fsldownloads/manifest.csv
  # The centos7 version suits for Ubuntu 14-20.
  fslver=6.0.4
  cd /usr/local
  wget -nv https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-${fslver}-centos7_64.tar.gz
  tar -zxf fsl-${fslver}-centos7_64.tar.gz
  rm fsl-${fslver}-centos7_64.tar.gz

  # FSL setup
  export FSLDIR=/usr/local/fsl
  . ${FSLDIR}/etc/fslconf/fsl.sh
  export PATH=${FSLDIR}/bin:${PATH}
  
  # Run the FSL python installer. A clue that we forgot this is an imglob error at runtime
  ${FSLDIR}/etc/fslconf/fslpython_install.sh
  
  # Fix imagemagick policy to allow PDF output. See https://usn.ubuntu.com/3785-1/
  sed -i 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
    /etc/ImageMagick-6/policy.xml
  
  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS && mkdir /wkdir
  
  # Clean up
  apt-get clean && apt-get -y autoremove


%environment

  # FSL
  export FSLDIR=/usr/local/fsl

  # Pipeline
  export PATH=/opt/src:${PATH}

%runscript
  wrapper.sh "$@"

