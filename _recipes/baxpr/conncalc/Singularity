Bootstrap: docker
From: ubuntu:20.04

%help
  Compute fMRI connectivity matrices and maps for MNI space ROIs.
  Info and usage:
    /opt/conncalc/README.md


%setup
  mkdir -p ${SINGULARITY_ROOTFS}/opt/conncalc


%files
  bin                          /opt/conncalc
  src                          /opt/conncalc
  build                        /opt/conncalc
  README.md                    /opt/conncalc
  ImageMagick-policy.xml       /opt
  
  # If we have a local copy of these packages, we can use them instead of downloading
  external/freesurfer-linux-centos7_x86_64-7.1.1.tar.gz   /opt
  external/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip     /opt
 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post
  apt update
  apt install -y wget unzip zip xvfb ghostscript imagemagick bc   # Misc tools
  apt install -y openjdk-8-jre                                    # Matlab
  apt install -y libglu1-mesa language-pack-en                    # Freeview
  
  # We need to make the ImageMagick security policy more permissive
  # https://www.kb.cert.org/vuls/id/332928
  mv /opt/ImageMagick-policy.xml /etc/ImageMagick-6/policy.xml

  # Download the Matlab Compiled Runtime installer, install, clean up
  matpfx=MATLAB_Runtime_R2019b_Update_6_glnxa64
  #wget -nv -P /opt https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/${matpfx}.zip
  unzip /opt/${matpfx}.zip -d /opt/${matpfx}
  /opt/${matpfx}/install -mode silent -agreeToLicense yes
  rm -r /opt/${matpfx} /opt/${matpfx}.zip

  # We need a "dry run" of SPM executable to extract the CTF archive.
  /opt/conncalc/bin/run_spm12.sh /usr/local/MATLAB/MATLAB_Runtime/v97 quit

  # Install Freesurfer. We just need freeview
  fsfile=freesurfer-linux-centos7_x86_64-7.1.1.tar.gz
  #wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.1.1/${fsfile}
  mkdir -p /usr/local/freesurfer/bin /usr/local/freesurfer/lib/vtk
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/bin/freeview
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/bin/qt.conf
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/build-stamp.txt
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/SetUpFreeSurfer.sh
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/FreeSurferEnv.sh
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/lib/qt
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/lib/vtk
  rm /opt/${fsfile}
  
  # Freeview needs a machine id here
  dbus-uuidgen > /etc/machine-id

  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS && mkdir /wkdir

  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove
  
  
%environment
  
  # Matlab. We don't need to set the Matlab library path here, because Matlab's
  # auto-generated run_??.sh script does it for us.
  export MATLAB_SHELL=/usr/bin/bash
  export MATLAB_RUNTIME=/usr/local/MATLAB/MATLAB_Runtime/v97
  
  # Freesurfer
  export FREESURFER_HOME=/usr/local/freesurfer
  
  # Path
  export PATH=/opt/conncalc/src:/opt/conncalc/bin:${PATH}


%runscript

  xwrapper.sh "$@"

