Bootstrap: docker
From: python:3.8

# copy files required for the app to run (this might be subsumed by pip command)

# get files from host (but we don't need any)

%environment
  # set environment variable to retrieve new image each time
  export SINGULARITY_DISABLE_CACHE=True

%post
  # install pip
  apt-get update
  apt-get install -y python3-pip
  pip install --upgrade pip


%runscript

  echo "Runscript; Python version is"
  python --version

  # cd into a defined dir
  cd Private/rrlfe_work

  # install dependencies into default python interpreter
  wget https://raw.githubusercontent.com/mwanakijiji/rrlfe/main/requirements_bare_versions.txt

  # clone rrlfe
  git clone https://github.com/mwanakijiji/rrlfe.git
  python -m pip install --user -r requirements_bare_versions.txt

  # install Robospect, suppress comments about being in detached HEAD state
  git clone https://github.com/czwa/robospect.py.git
  cd robospect.py
  git -c advice.detachedHead=false checkout tags/v0.76
  mkdir tmp/
  python ./setup.py install --user
  cd ../rrlfe

  # do a pip freeze
  #pip freeze --user > freeze_bad.txt

  # copy line list file
  cp ll ../robospect.py/tmp/

  # Run this line in command line (replacing Singularity file name as needed)
  # singularity exec --bind ${SINGULARITY_ROOTFS}/rrlfe:/Users/bandari/Documents/git.repos/rrlfe,${SINGULARITY_ROOTFS}/sandbox/robospect.py:/Users/bandari/Documents/git.repos/robospect.py test.sif python rrlfe/high_level_reduction_script.py
