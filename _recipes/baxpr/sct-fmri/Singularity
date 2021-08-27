Bootstrap: docker
From: ubuntu:20.04

%help

  Full installation of Spinal Cord Toolbox in /opt/sct. For more information:
    /opt/sctfmri/README.md


%setup
  mkdir -p ${SINGULARITY_ROOTFS}/opt/sct
  mkdir -p ${SINGULARITY_ROOTFS}/opt/sctfmri

  
%files
  src                                           /opt/sctfmri
  README.md                                     /opt/sctfmri
  ImageMagick-policy.xml                        /opt
  external/fsl-6.0.4-centos7_64.tar.gz          /opt


%post

  apt-get update

  # Misc tools needed for basic operations
  apt install -y wget unzip zip bc
  
  # ImageMagick and Ghostscript are very handy for making PDF QA reports.
  apt install -y ghostscript imagemagick

  # ImageMagick security policy needs to be more permissive
  # https://www.kb.cert.org/vuls/id/332928
  mv /opt/ImageMagick-policy.xml /etc/ImageMagick-6/policy.xml
    
  # Headless X11
  apt install -y xvfb
     
  # For AFNI
  apt install -y libxkbcommon-x11-0

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

  # SCT installation
  apt-get install -y curl wget gcc git libglib2.0-0
  repo=spinalcordtoolbox
  sctver=5.3.0
  sctdir=/opt/sct
  git clone --branch ${sctver} --depth 1 https://github.com/${repo}/spinalcordtoolbox.git ${sctdir}
  cd ${sctdir}
  ./install_sct -i -y

  # Add DICOM, NII, time to the SCT python
  ${sctdir}/python/envs/venv_sct/bin/pip install pydicom nilearn nitime

  # Create a few directories to use as bind points when we run the container
  mkdir /INPUTS
  mkdir /OUTPUTS
  mkdir /wkdir
  
  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove
  

%environment

  # SCT
  export SCTDIR=/opt/sct
  export PATH=${SCTDIR}/bin:${SCTDIR}/python/bin:${PATH}
  . ${SCTDIR}/python/etc/profile.d/conda.sh
  conda activate venv_sct

 # FSL
  export FSLDIR=/usr/local/fsl
  . ${FSLDIR}/etc/fslconf/fsl.sh
  export PATH=${FSLDIR}/bin:${PATH}  
  
  # Pipeline
  export PATH=/opt/sctfmri/src:${PATH}


%runscript

  entrypoint.sh "$@"


