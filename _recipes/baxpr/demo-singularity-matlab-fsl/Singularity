# Starting point for a container should be reasonably trustworthy, in this case
# an official base Ubuntu image from Docker https://hub.docker.com/_/ubuntu
Bootstrap: docker
From: ubuntu:20.04


%help
  Demo of a singularity container that runs a Matlab program. FSL is also 
  included, as it's a handy resource for a lot of image processing and figure
  creation.
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

  # If we're installing MCR and FSL from local copies, we need to copy those
  # into the container as well. We'll delete them after the installs.
  MATLAB_Runtime_R2019b_Update_6_glnxa64.zip   /opt/pipeline
  fsl-6.0.4-centos7_64.tar.gz                  /opt/pipeline
  
 
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
  
  # Ghostscript and ImageMagick are very handy for making PDF QA reports. Note,
  # older but still recent versions of ImageMagick had security issues needing
  # modifications to /etc/ImageMagick-6/policy.xml before PDFs could be created,
  # https://usn.ubuntu.com/3785-1/. Newer versions are workable out of the box.
  apt install -y ghostscript imagemagick
  
  # xvfb is used to perform graphics operations "headless" to create figures,
  # images, etc. This pipeline will be run entirely on the virtual display,
  # although it's also possible to do X operations piecemeal/as needed.
  apt install -y xvfb

  # Matlab Runtime requires this Java runtime
  apt install -y openjdk-8-jre
  
  # FSL 6.0.4 requires these two additional packages
  apt install -y libopenblas-base language-pack-en
  
  # Download the Matlab Compiled Runtime installer, install, clean up. The 
  # installed version of the runtime must match the Matlab version that was used
  # to compile the code. Each version of the runtime has its own download URL
  # and installed location:
  # https://www.mathworks.com/products/compiler/matlab-runtime.html
  #runtime_url=https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  #runtime_location=/usr/local/MATLAB/MATLAB_Runtime/v97
  #mkdir /MCR
  #wget -nv -P /MCR ${runtime_url} -O /MCR/runtime_installer.zip
  #unzip -qq /MCR/runtime_installer.zip -d /MCR/runtime_installer
  #/MCR/runtime_installer/install -mode silent -agreeToLicense yes
  #rm -r /MCR/runtime_installer /MCR/runtime_installer.zip
  #rmdir /MCR
  
  # Alternatively, we can install the MCR from a local copy of the file if there
  # is one, and save the download time during build.
  runtime_file=/opt/pipeline/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip
  runtime_location=/usr/local/MATLAB/MATLAB_Runtime/v97
  mkdir /MCR
  unzip -qq "${runtime_file}" -d /MCR/runtime_installer
  /MCR/runtime_installer/install -mode silent -agreeToLicense yes
  rm -r /MCR/runtime_installer "${runtime_file}"
  rmdir /MCR
  
  # We need to run the matlab executable now to extract the CTF archive, because
  # now is the only time the container is writeable. The matlab entrypoint has
  # a bit at the beginning that makes this work.
  /opt/pipeline/matlab/bin/run_matlab_entrypoint.sh ${runtime_location} quit

  # FSL. The centos7 version suits for Ubuntu 14-20. For available versions, see
  # https://fsl.fmrib.ox.ac.uk/fsldownloads/manifest.csv
  #fslfile=fsl-6.0.4-centos7_64.tar.gz
  #cd /usr/local
  #wget -nv https://fsl.fmrib.ox.ac.uk/fsldownloads/${fslfile}
  #tar -zxf ${fslfile}
  #rm ${fslfile}
  #cd -

  # Or we can install FSL from a local file
  fslfile=/opt/pipeline/fsl-6.0.4-centos7_64.tar.gz
  tar -zxf ${fslfile} -C /usr/local
  rm ${fslfile}

  # Run the FSL setup so we can run the python installer
  export FSLDIR=/usr/local/fsl
  . ${FSLDIR}/etc/fslconf/fsl.sh
  export PATH=${FSLDIR}/bin:${PATH}
  
  # Run the FSL python installer, needed for fsleyes among other things. This 
  # is normally done in the post_install phase when FSL's installer is run, but
  # we do it manually here. A clue that we forgot this is an imglob error at
  # runtime.
  ${FSLDIR}/etc/fslconf/fslpython_install.sh
  
  # Create a few directories to use as bind points when we run the container
  mkdir /INPUTS
  mkdir /OUTPUTS
  mkdir /workdir
  
  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove
  
  
%environment

  # Matlab 
  # We set Matlab's default shell, in case we call any shell commands from 
  # Matlab. We also set the runtime's installed location, as it's needed to run
  # the compiled binary - note, this must match the runtime_location specified
  # above in the 'post' section. However we don't need to set the Matlab library
  # path here, because Matlab's auto-generated run_??.sh script does it for us.
  export MATLAB_SHELL=/bin/bash
  export MATLAB_RUNTIME=/usr/local/MATLAB/MATLAB_Runtime/v97

  # FSL
  # We set FSLDIR here, but the rest of FSL setup will have to be done at 
  # run time in the pipeline code:
  #       . ${FSLDIR}/etc/fslconf/fsl.sh
  #       export PATH=${FSLDIR}/bin:${PATH}
  export FSLDIR=/usr/local/fsl
  
  # Path
  # We add the src directory, which contains shell scripts etc; and the 
  # matlab/bin directory, which contains the compiled Matlab binary.
  export PATH=/opt/pipeline/src:/opt/pipeline/matlab/bin:${PATH}


%runscript

  # We just call our entrypoint, passing along all the command line arguments 
  # that were given at the singularity run command line.
  pipeline_entrypoint.sh "$@"

