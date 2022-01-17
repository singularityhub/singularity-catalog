Bootstrap: docker
From: ubuntu:20.04

%help
	Ask for help text
	Info and usage: /opt/pipeline/README.md

%setup
  # Create an installation directory for the codebase. We can often finagle this
  # in the 'files' section and forgo the 'setup' section entirely, but it's 
  # clearer this way.
  mkdir -p "${SINGULARITY_ROOTFS}"/opt/pipeline


%files
  # Used to copy files into the container
  matlab 			/opt/pipeline
  src 			/opt/pipeline
  README.md 	/opt/pipeline

%labels
  Maintainer r.dylan.lawless@vumc.org

%post
  
  # Install misc tools

  apt-get update
  apt-get install -y --no-install-recommends \
    wget \
    unzip \
    zip \
    bc \
    ghostscript \
    imagemagick \
    xvfb \
    curl \
    ca-certificates \
    default-jre \
    libxtst6 \
    python3.8 
  
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*

  # Matlab Compiled Runtime installation. Uncomment the wget command to download 
  # The installed version of the runtime must match the Matlab version that was used to compile the code. 
  # Each version of the runtime has its own download URL and installed location:
  # https://www.mathworks.com/products/compiler/matlab-runtime.html
  mcr_url=https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/9/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_9_glnxa64.zip
  mcr_location=/usr/local/MATLAB/MATLAB_Runtime/v97
  wget -nv ${mcr_url} -O /opt/mcr_installer.zip
  unzip /opt/mcr_installer.zip -d /opt/mcr_installer
  /opt/mcr_installer/install -mode silent -agreeToLicense yes
  rm -r /opt/mcr_installer /opt/mcr_installer.zip

  # Matlab executable must be run now to extract the CTF archive, because
  # now is the only time the container is writeable. The matlab entrypoint has
  # a bit at the beginning that makes this work.
  /opt/pipeline/matlab/bin/run_spm12.sh ${mcr_location} quit

  # Install and set up miniconda
  curl -sSLO https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh && \
  bash Miniconda3-4.5.11-Linux-x86_64.sh -b -p /usr/local/miniconda && \
  rm Miniconda3-4.5.11-Linux-x86_64.sh

  PATH="/usr/local/miniconda/bin:$PATH" \
  CPATH="/usr/local/miniconda/include/:$CPATH" \
  LANG="C.UTF-8" \
  LC_ALL="C.UTF-8" \
  PYTHONNOUSERSITE=1
  MCR_INHIBIT_CTF_LOCK=1

  # Installing python packages
  conda install -y pip=19.1
  chmod -R a+rX /usr/local/miniconda; sync && \
  chmod +x /usr/local/miniconda/bin/*; sync && \
  #conda-build purge-all; sync && \
  #conda clean -tipsy && sync
  
  # Installing pip packages
  python3 -m pip install --no-cache-dir fpdf 

  # Create a few directories to use as bind points when we run the container
  mkdir /INPUTS
  mkdir /OUTPUTS

  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove

%environment

  # Matlab 
  # We set Matlab's default shell, in case we call any shell commands from 
  # Matlab. We also set the runtime's installed location, as it's needed to run
  # the compiled binary - note, this must match the mcr_location specified
  # above in the 'post' section. However we don't need to set the Matlab library
  # path here, because Matlab's auto-generated run_??.sh script does it for us.
  export MATLAB_SHELL=/bin/bash
  export MATLAB_RUNTIME=/usr/local/MATLAB/MATLAB_Runtime/v97
  # Path
  # We add the src directory, which contains shell scripts etc; and the 
  # matlab/bin directory, which contains the compiled Matlab binary.
  export PATH=/opt/pipeline/src:/opt/pipeline/matlab/bin:${PATH}
  export MCR_INHIBIT_CTF_LOCK=1

%runscript
  
  alias python='python3.8'

  # We just call our entrypoint, passing along all the command line arguments 
  # that were given at the singularity run command line.
  pipeline_entrypoint.sh "$@"