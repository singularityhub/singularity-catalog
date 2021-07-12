Bootstrap: docker
From: ubuntu:20.04

%help

  Runs FSL's bedpost on outputs of dtiQA_v7. See /opt/README.md


%setup

  mkdir -p ${SINGULARITY_ROOTFS}/opt/bedpost


%files

  src                                    /opt/bedpost
  README.md                              /opt/bedpost
  ImageMagick-policy.xml                 /opt
  external/fsl-6.0.4-centos7_64.tar.gz   /opt

%post

  apt-get update
  apt-get install -y wget unzip zip xvfb ghostscript imagemagick bc

  # Fix imagemagick policy to allow PDF output. See https://usn.ubuntu.com/3785-1/
  mv /opt/ImageMagick-policy.xml /etc/ImageMagick-6/policy.xml

  # Install python3 with pip and use by default
  # https://stackoverflow.com/a/61878185
  apt install -y python3 python3-pip python-is-python3
  pip3 install pandas nilearn nibabel

  # FSL dependencies, h/t https://github.com/MPIB/singularity-fsl
  #            debian              ubuntu
  #            libjpeg62-turbo ->  libjpeg-turbo8
  #            libmng1         ->  libmng2
  apt install -y \
    wget python2-minimal libgomp1 ca-certificates \
    libglu1-mesa libgl1-mesa-glx libsm6 libice6 libxt6 \
    libjpeg-turbo8 libpng16-16 libxrender1 libxcursor1 \
    libxinerama1 libfreetype6 libxft2 libxrandr2 libmng2 \
    libgtk2.0-0 libpulse0 libasound2 libcaca0 libopenblas-base \
    language-pack-en bzip2 dc bc

  # FSL. The centos7 version suits for Ubuntu 14-20. For available versions, see
  # https://fsl.fmrib.ox.ac.uk/fsldownloads/manifest.csv 
  wget -nv -P /opt https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py

  # Download the archive as part of the install
  #python2 /opt/fslinstaller.py -d /usr/local/fsl -V 6.0.4
  #rm /opt/fslinstaller.py

  # Or install from an already-downloaded copy of the archive
  python2 /opt/fslinstaller.py -M -f /opt/fsl-6.0.4-centos7_64.tar.gz -d /usr/local/fsl
  rm /opt/fslinstaller.py /opt/fsl-6.0.4-centos7_64.tar.gz
  
  echo '/usr/local/fsl/lib' > /etc/ld.so.conf.d/fsl.conf
  ldconfig
    
  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS && mkdir /wkdir
  
  # Clean up
  apt-get clean && apt-get -y autoremove


%environment

  # FSL
  export FSLDIR=/usr/local/fsl
  . ${FSLDIR}/etc/fslconf/fsl.sh
  export PATH=${FSLDIR}/bin:${PATH}

  # Pipeline
  export PATH=/opt/bedpost/src:${PATH}


%runscript

  xwrapper.sh "$@"

