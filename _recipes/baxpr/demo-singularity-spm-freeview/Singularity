Bootstrap: docker
From: ubuntu:20.04

%help
  Demo of a singularity container that runs a Matlab program. Freesurfer's
  Freeview is also included, as it's a handy resource for figure creation.
  Info and usage: /opt/pipeline/README.md



%setup

  # Create an installation directory for the codebase. We can often finagle this
  # in the 'files' section and forgo the 'setup' section entirely, but it's 
  # clearer this way.
  mkdir -p "${SINGULARITY_ROOTFS}"/opt/pipeline


%files

  # Copy all the code into the container's installation directory. We do this in
  # specific pieces to avoid bulk copying any extra junk we might have floating
  # around in the local working copy of the repository. This Singularity recipe
  # itself is put in the container automatically during the build, at 
  # /.singularity.d/Singularity
  #
  # The Matlab source code is not actually used, because we'll run the compiled
  # version with the Matlab Runtime instead. But the source code will be in the
  # container for reference. Don't let these get out of sync, i.e. don't change
  # the Matlab source code and then forget to recompile it before building the
  # container.
  src                          /opt/pipeline
  matlab                       /opt/pipeline
  README.md                    /opt/pipeline
  ImageMagick-policy.xml       /opt
  
  # If we have local copies of these packages, we can use them instead of downloading
  external/freesurfer-linux-centos7_x86_64-7.1.1.tar.gz   /opt
  external/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip     /opt/mcr_installer.zip
 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post

  # Make sure we get the newest versions of OS packages and the package data. 
  # Note, this means if we build the container twice with some time in between, 
  # versions of things will likely be different. We could specify particular 
  # versions below if needed - easy (if tedious) to find out what they are in an
  # existing container.
  apt update
  
  # Misc tools needed for basic operations
  apt install -y wget unzip zip bc
  
  # Ghostscript and ImageMagick are very handy for making PDF QA reports.
  apt install -y ghostscript imagemagick
  
  # xvfb is used to perform graphics operations "headless" to create figures,
  # images, etc. This pipeline will be run entirely on the virtual display,
  # although it's also possible to do X operations piecemeal/as needed.
  apt install -y xvfb

  # Matlab Runtime requires this Java runtime
  apt install -y openjdk-8-jre
  
  # Freeview requires this graphics library
  apt install -y libglu1-mesa
  
  # We need to make the ImageMagick security policy more permissive
  # https://www.kb.cert.org/vuls/id/332928
  mv /opt/ImageMagick-policy.xml /etc/ImageMagick-6/policy.xml

  # Install the Matlab Compiled Runtime. Uncomment the wget command to download 
  # the install package instead of using a local copy. The installed version of 
  # the runtime must match the Matlab version that was used to compile the code. 
  # Each version of the runtime has its own download URL and installed location:
  # https://www.mathworks.com/products/compiler/matlab-runtime.html
  runtime_url=https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  runtime_location=/usr/local/MATLAB/MATLAB_Runtime/v97
  #wget -nv -P /opt ${runtime_url} -O /opt/mcr_installer.zip
  unzip /opt/mcr_installer.zip -d /opt/mcr_installer
  /opt/mcr_installer/install -mode silent -agreeToLicense yes
  rm -r /opt/mcr_installer /opt/mcr_installer.zip

  # We need to run the matlab executable now to extract the CTF archive, because
  # now is the only time the container is writeable. The run_spm12.sh command
  # can be used with SPM12's 'function' argument to run any command that was
  # available in the Matlab path at compile time.
  /opt/pipeline/bin/run_spm12.sh ${runtime_location} function exit

  # Install Freesurfer. We are only installing freeview, so we only extract those 
  # few files that are required for it. Uncomment the wget command to download 
  # the install package instead of using a local copy.
  # https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
  fsfile=freesurfer-linux-centos7_x86_64-7.1.1.tar.gz
  #wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.1.1/${fsfile}
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/bin/freeview
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/bin/qt.conf
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/build-stamp.txt
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/SetUpFreeSurfer.sh
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/FreeSurferEnv.sh
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/lib/qt
  tar -zxf /opt/${fsfile} -C /usr/local freesurfer/lib/vtk
  rm /opt/${fsfile}
  
  # Freeview needs a machine id here. If we don't create one, we'll hear about it
  # at run time.
  dbus-uuidgen > /etc/machine-id

  # Create a few directories to use as bind points when we run the container
  mkdir /INPUTS
  mkdir /OUTPUTS
  mkdir /wkdir

  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove
  
  
%environment
  
  # Matlab.
  # We set Matlab's default shell, in case we call any shell commands from 
  # Matlab. We also set the runtime's installed location, as it's needed to run
  # the compiled binary - note, this must match the runtime_location specified
  # above in the 'post' section. However we don't need to set the Matlab library
  # path here, because Matlab's auto-generated run_??.sh script does it for us.
  export MATLAB_SHELL=/usr/bin/bash
  export MATLAB_RUNTIME=/usr/local/MATLAB/MATLAB_Runtime/v97
  
  # Freesurfer
  # We set FREESURFER_HOME here, but the rest of Freesurfer setup will have to 
  # be done at run time in the pipeline code:
  #     . $FREESURFER_HOME/SetUpFreeSurfer.sh  
  export FREESURFER_HOME=/usr/local/freesurfer
  
  # Path
  # We add the src directory, which contains shell scripts etc; and the 
  # matlab/bin directory, which contains the compiled Matlab binary.
  export PATH=/opt/pipeline/src:/opt/pipeline/matlab/bin:${PATH}


%runscript

  # We just call our entrypoint, passing along all the command line arguments 
  # that were given at the singularity run command line.
  pipeline_entrypoint.sh "$@"

