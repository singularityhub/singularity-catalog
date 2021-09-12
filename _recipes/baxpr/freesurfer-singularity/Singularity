Bootstrap: docker
From: centos:7.9.2009

%help

Freesurfer recon-all. Requires a valid license file at runtime.

Useful information within the container:
  /opt/README.md                          Summary and references
  /opt/USAGE.md                           Detailed instructions
  /usr/local/freesurfer/build-stamp.txt   Specific Freesurfer version


%setup

  mkdir -p ${SINGULARITY_ROOTFS}/opt/freesurfer-singularity


%files

  src          /opt/freesurfer-singularity
  USAGE.md     /opt/freesurfer-singularity
  README.md    /opt/freesurfer-singularity
  
  external/fsl-6.0.4-centos7_64.tar.gz                     /opt
  external/freesurfer-linux-centos7_x86_64-7.2.0.tar.gz    /opt
  

%post
  
  # Versions
  fsl_version=6.0.4
  freesurfer_version=7.2.0
  
  # For installs
  yum -y update
  yum -y install unzip wget
  
  # For Freesurfer
  yum -y install tcsh bc mesa-libGLU libgomp perl mesa-dri-drivers libicu
  
  # For FSL
  #yum -y install epel-release
  #yum -y install openblas-devel
  
  # For X
  yum -y install xorg-x11-server-Xvfb xorg-x11-xauth which

  # For PDF outputs
  yum -y install ImageMagick
  
  # Python modules
  yum -y install python3
  pip3 install pandas numpy
  
  # fslstats via local copy
  tar -zx -f /opt/fsl-${fsl_version}-centos7_64.tar.gz fsl/bin/fslstats -C /usr/local
  
  # fslstats via download
  #wget -nv -P /opt https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-${fsl_version}-centos7_64.tar.gz
  #tar -zx -f /opt/fsl-${fsl_version}-centos7_64.tar.gz fsl/bin/fslstats -C /usr/local
  #rm -r fsl /opt/fsl-${fsl_version}-centos7_64.tar.gz

  # Freesurfer via local file
  tar -zxf /opt/freesurfer-linux-centos7_x86_64-${freesurfer_version}.tar.gz -C /usr/local
  
  # Freesurfer via network download
  #cd /usr/local
  #wget -nv https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/${freesurfer_version}/freesurfer-linux-centos7_x86_64-${freesurfer_version}.tar.gz
  #tar -zxf freesurfer-linux-centos7_x86_64-${freesurfer_version}.tar.gz
  #rm freesurfer-linux-centos7_x86_64-dev.tar.gz

  # Freeview needs a machine id here
  dbus-uuidgen > /etc/machine-id
  
  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS && mkdir /wkdir


%environment

  # Script path
  export PATH=/opt/freesurfer-singularity/src:$PATH

  # FSL (we only use fslstats so no need for the full setup)
  export FSLOUTPUTTYPE=NIFTI_GZ
  
  # Freesurfer
  # The XDG_RUNTIME_DIR setting avoids a warning message. The remaining setup
  # will need to be done at run time:
  #     . $FREESURFER_HOME/SetUpFreeSurfer.sh
  export FREESURFER_HOME=/usr/local/freesurfer
  export XDG_RUNTIME_DIR=/tmp

%runscript
  xvfb-run --server-num=$(($$ + 99)) \
  --server-args='-screen 0 1600x1200x24 -ac +extension GLX' \
  bash run_everything.sh "$@"

