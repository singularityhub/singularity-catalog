Bootstrap: docker
From: ubuntu:20.04

%help
  Compute fMRI connectivity matrices and maps for MNI space ROIs.
  Info and usage:
    /opt/mniconn/README.md
    /opt/mniconn/build/test_sing_container.sh


%setup
  mkdir -p ${SINGULARITY_ROOTFS}/opt/mniconn


%files
  bin                          /opt/mniconn
  src                          /opt/mniconn
  build                        /opt/mniconn
  README.md                    /opt/mniconn

 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post
  apt-get update
  apt-get install -y wget unzip zip xvfb ghostscript imagemagick bc   # Misc tools
  apt-get install -y openjdk-8-jre                                    # Matlab
  apt-get install -y libopenblas-base language-pack-en                # FSL
  apt-get install -y libglu1-mesa                                     # Freeview
  
  # Fix imagemagick policy to allow PDF output. See https://usn.ubuntu.com/3785-1/
  sed -i 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
    /etc/ImageMagick-6/policy.xml
  
  # Download the Matlab Compiled Runtime installer, install, clean up
  mkdir /MCR
  wget -nv -P /MCR https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  unzip /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip -d /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64
  /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64/install -mode silent -agreeToLicense yes
  rm -r /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64 /MCR/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  rmdir /MCR

  # Install Freesurfer. We just need freeview
  wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/dev/freesurfer-linux-centos7_x86_64-dev.tar.gz
  cd /usr/local
  tar -zxf freesurfer-linux-centos7_x86_64-dev.tar.gz
  rm freesurfer-linux-centos7_x86_64-dev.tar.gz
  mkdir -p /usr/local/fstemp/bin /usr/local/fstemp/lib/vtk
  cp /usr/local/freesurfer/bin/freeview         /usr/local/fstemp/bin
  cp /usr/local/freesurfer/bin/qt.conf          /usr/local/fstemp/bin
  cp /usr/local/freesurfer/build-stamp.txt      /usr/local/fstemp
  cp /usr/local/freesurfer/SetUpFreeSurfer.sh   /usr/local/fstemp
  cp /usr/local/freesurfer/FreeSurferEnv.sh     /usr/local/fstemp
  cp -r /usr/local/freesurfer/lib/qt            /usr/local/fstemp/lib
  cp -r /usr/local/freesurfer/lib/vtk/*         /usr/local/fstemp/lib/vtk
  rm -fr /usr/local/freesurfer
  mv /usr/local/fstemp /usr/local/freesurfer
  
  # Freeview needs a machine id here
  dbus-uuidgen > /etc/machine-id

  # We need a piece of FSL (fslstats, fslmaths)
  wget -nv -P /opt https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.0-centos7_64.tar.gz
  cd /opt
  tar -zxf fsl-6.0.0-centos7_64.tar.gz
  mkdir -p /usr/local/fsl/bin
  cp fsl/bin/fslstats /usr/local/fsl/bin
  cp fsl/bin/fslmaths /usr/local/fsl/bin
  rm -r fsl fsl-6.0.0-centos7_64.tar.gz

  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS

  # Singularity-hub doesn't work with github LFS (it gets the pointer info instead 
  # of the actual file) so we get the compiled matlab executable via direct download.
  # Not needed for local build.
  rm /opt/mniconn/bin/spm12.ctf
  wget -nv -P /opt/mniconn/bin https://github.com/baxpr/mniconn/raw/master/bin/spm12.ctf

  # Also need a "dry run" of SPM executable to avoid directory creation errors later.
  /opt/mniconn/bin/run_spm12.sh /usr/local/MATLAB/MATLAB_Runtime/v97 quit


%environment
  # We don't need to set the Matlab library path here, because Matlab's
  # auto-generated run_??.sh script does it for us.
  
  # Matlab shell
  MATLAB_SHELL=/bin/bash
  
  # Freesurfer
  export FREESURFER_HOME=/usr/local/freesurfer

  # FSL (we only use fslstats so no need for the full setup)
  export FSLOUTPUTTYPE=NIFTI_GZ
  
  # Path
  export PATH=/opt/mniconn/src:/usr/local/fsl/bin:${PATH}


%runscript
  xvfb-run --server-num=$(($$ + 99)) \
  --server-args='-screen 0 1600x1200x24 -ac +extension GLX' \
  bash /opt/mniconn/bin/run_spm12.sh \
  /usr/local/MATLAB/MATLAB_Runtime/v97 function mniconn "$@"

