Bootstrap: docker
From: ubuntu:18.04

%help
  SPM12 warp of segmentation image to native space.
  Info and usage:
    /opt/makerois/README.md


%files
  # No local files used - we will grab from github using the release tag
  # to make sure we're consistent with the specific desired commit
 
 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post
  
  # Version we will use - github release tag
  version=1.0.13
  
  # apt modules
  apt-get update                                                 > /dev/null
  apt-get install -y wget unzip zip xvfb ghostscript imagemagick > /dev/null   # Misc tools
  apt-get install -y openjdk-8-jre                               > /dev/null   # Matlab/SPM

  # Download the release
  cd /opt
  wget -nv -O v${version}.tar.gz https://github.com/baxpr/makerois-PMAT/archive/v${version}.tar.gz
  tar -zxf v${version}.tar.gz
  mv makerois-PMAT-${version} makerois
  rm v${version}.tar.gz
  
  # Github doesn't put the actual file in the tarball where LFS is used (it gets the pointer 
  # info instead) so we get the compiled matlab executable via direct download.
  rm /opt/makerois/bin/spm12.ctf
  wget -nv -O /opt/makerois/bin/spm12.ctf https://github.com/baxpr/makerois-PMAT/blob/v${version}/bin/spm12.ctf?raw=true
  
  # Make an info file with the version tag
  echo "https://github.com/baxpr/makerois-PMAT release v${version}" > /opt/makerois/version.txt
  
  # FSL dependencies, h/t https://github.com/MPIB/singularity-fsl
  #    debian vs ubuntu:
  #            libjpeg62-turbo ->  libjpeg-turbo8
  #            libmng1         ->  libmng2
  apt-get -y install wget python-minimal libgomp1 ca-certificates \
          libglu1-mesa libgl1-mesa-glx libsm6 libice6 libxt6 \
          libjpeg-turbo8 libpng16-16 libxrender1 libxcursor1 \
          libxinerama1 libfreetype6 libxft2 libxrandr2 libmng2 \
          libgtk2.0-0 libpulse0 libasound2 libcaca0 libopenblas-base \
          bzip2 dc bc > /dev/null
  
  # Fix imagemagick policy to allow PDF output. See https://usn.ubuntu.com/3785-1/
  sed -i 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
    /etc/ImageMagick-6/policy.xml
  
  # Download the Matlab Compiled Runtime installer, install, clean up
  mkdir /MCR
  wget -nv -P /MCR https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  unzip /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip -d /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64 > /dev/null
  /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64/install -mode silent -agreeToLicense yes > /dev/null
  rm -r /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64 /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  rmdir /MCR

  # Need a dry run of SPM executable to avoid directory creation errors later.
  /opt/makerois/bin/run_spm12.sh /usr/local/MATLAB/MATLAB_Runtime/v97 quit

  # Install Freesurfer. We just need mri_convert and mri_label2vol
  wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/dev/freesurfer-linux-centos7_x86_64-dev.tar.gz
  cd /usr/local
  tar -zxf freesurfer-linux-centos7_x86_64-dev.tar.gz
  rm freesurfer-linux-centos7_x86_64-dev.tar.gz
  mkdir -p /usr/local/fstemp/bin /usr/local/fstemp/lib/vtk
  cp /usr/local/freesurfer/bin/mri_convert      /usr/local/fstemp/bin
  cp /usr/local/freesurfer/bin/mri_label2vol    /usr/local/fstemp/bin
  cp /usr/local/freesurfer/build-stamp.txt      /usr/local/fstemp
  cp /usr/local/freesurfer/SetUpFreeSurfer.sh   /usr/local/fstemp
  cp /usr/local/freesurfer/FreeSurferEnv.sh     /usr/local/fstemp
  rm -fr /usr/local/freesurfer
  mv /usr/local/fstemp /usr/local/freesurfer
  
  # Freeview needs a machine id here
  dbus-uuidgen > /etc/machine-id
  
  # Get and install main FSL package
  fsl_version=6.0.2
  cd /usr/local
  wget -nv https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-${fsl_version}-centos7_64.tar.gz
  tar zxf fsl-${fsl_version}-centos7_64.tar.gz
  rm fsl-${fsl_version}-centos7_64.tar.gz
  
  # FSL setup
  export FSLDIR=/usr/local/fsl
  . ${FSLDIR}/etc/fslconf/fsl.sh
  export PATH=${FSLDIR}/bin:${PATH}

  # Run the FSL python installer
  ${FSLDIR}/etc/fslconf/fslpython_install.sh

  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS


%environment
  # We don't need to set the Matlab library path here, because Matlab's
  # auto-generated run_??.sh script does it for us.
  
  # Matlab shell
  export MATLAB_SHELL=/bin/bash
  
  # Path
  export PATH=/opt/makerois/src:/usr/local/fsl/bin:${PATH}


%runscript
  xwrapper.sh function makerois "$@"
