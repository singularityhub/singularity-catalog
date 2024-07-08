Bootstrap: docker
From: ubuntu:18.04

%help
Robust diffusion tensor reconstruction with Camino.
Codebase: /opt/dticam
Info: /opt/dticam/README.md


%setup
  mkdir -p ${SINGULARITY_ROOTFS}/opt/dticam


%files
  src                          /opt/dticam
  README.md                    /opt/dticam

 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post

  apt-get update
  
  apt-get install -y zip unzip wget                  # Misc tools
  apt-get install -y binutils xz-utils               # For workaround below
  apt-get install -y xvfb                            # Headless X11 support
  apt-get install -y ghostscript imagemagick         # PNG and PDF tools
  
  # Camino dependencies
  apt-get install -y openjdk-8-jre openjdk-8-jdk build-essential
  
  # FSL dependencies incl for fsleyes, h/t https://github.com/MPIB/singularity-fsl
  #    debian vs ubuntu:
  #            libjpeg62-turbo ->  libjpeg-turbo8
  #            libmng1         ->  libmng2
  apt-get install -y python-minimal libgomp1 ca-certificates \
					 libglu1-mesa libgl1-mesa-glx libsm6 libice6 libxt6 \
					 libjpeg-turbo8 libpng16-16 libxrender1 libxcursor1 \
					 libxinerama1 libfreetype6 libxft2 libxrandr2 libmng2 \
					 libgtk2.0-0 libpulse0 libasound2 libcaca0 libopenblas-base \
					 bzip2 dc bc language-pack-en
  
  # Workaround for filename case collision in linux-libc-dev
  # https://stackoverflow.com/questions/15599592/compiling-linux-kernel-error-xt-connmark-h
  # https://superuser.com/questions/1238903/cant-install-linux-libc-dev-in-ubuntu-on-windows
  mkdir pkgtemp && cd pkgtemp
  apt-get download linux-libc-dev
  ar x linux-libc-dev*deb
  tar xJf data.tar.xz
  tar cJf data.tar.xz ./usr
  ar rcs linux-libc-dev*.deb debian-binary control.tar.xz data.tar.xz
  dpkg -i linux-libc-dev*.deb
  cd .. && rm -r pkgtemp

  # Download and install Camino
  camver=1c4ef77615d103d43adcff6c79b72d0bbdac0897
  cd /usr/local
  wget https://sourceforge.net/projects/camino/files/camino-code-${camver}.zip
  unzip camino-code-${camver}.zip
  rm -fr __MACOSX
  mv camino-code-${camver} camino
  cd camino
  make

  # Get and install main FSL package
  #fsl_version=5.0.11
  #cd /usr/local
  #wget -q https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-${fsl_version}-centos7_64.tar.gz
  #tar zxf fsl-${fsl_version}-centos7_64.tar.gz
  #rm fsl-${fsl_version}-centos7_64.tar.gz
  #mv fsl fsl5
  
  # FSL setup
  #export FSLDIR=/usr/local/fsl5
  #. ${FSLDIR}/etc/fslconf/fsl.sh
  #export PATH=${FSLDIR}/bin:${PATH}

  # Run the FSL python installer
  #${FSLDIR}/etc/fslconf/fslpython_install.sh
  
  # Remove non-working old fsleyes
  #rm -r ${FSLDIR}/bin/fsleyes ${FSLDIR}/bin/FSLeyes

  # Run the edited FSL 6 python installer to get fsleyes in /usr/local/fsl6/fslpython/envs/fslpython/bin/fsleyes
  #/opt/thaltrack-whole/src/fslconf6/fslpython_install_local.sh

  # Install Freesurfer. We just need mri_convert
  #fs_version=7.1.0
  #fs_tgz=freesurfer-linux-centos7_x86_64-${fs_version}.tar.gz
  #wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/${fs_version}/${fs_tgz}
  #cd /usr/local
  #tar -zxf ${fs_tgz} freesurfer/bin/mri_convert
  #tar -zxf ${fs_tgz} freesurfer/build-stamp.txt
  #tar -zxf ${fs_tgz} freesurfer/SetUpFreeSurfer.sh
  #tar -zxf ${fs_tgz} freesurfer/FreeSurferEnv.sh
  #rm ${fs_tgz}
  
  # Fix imagemagick policy to allow PDF output. See https://usn.ubuntu.com/3785-1/
  sed -i 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
    /etc/ImageMagick-6/policy.xml
  
  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS

  # Clean up
  apt-get clean && apt-get -y autoremove


%environment

  # FSL, including the FSL6 python bin dir for fsleyes but at lower precedence
  #export FSLDIR=/usr/local/fsl5
  #. ${FSLDIR}/etc/fslconf/fsl.sh
  #export PATH=${FSLDIR}/bin:/usr/local/fsl6/fslpython/envs/fslpython/bin:${PATH}

  # Freesurfer
  #export FREESURFER_HOME=/usr/local/freesurfer
 
  # Pipeline
  export PATH=/opt/dticam/src:${PATH}


%runscript

  xwrapper.sh pipeline.sh "$@"

