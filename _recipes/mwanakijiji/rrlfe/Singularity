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
  #cd Private/rrlfe_work

  echo "sing home"
  echo $HOME

  # install dependencies into default python interpreter
  wget https://raw.githubusercontent.com/mwanakijiji/rrlfe/main/requirements_bare_versions.txt

  # clone rrlfe
  git clone https://github.com/mwanakijiji/rrlfe.git

  # install stuff
  python -m pip install --user -r requirements_bare_versions.txt

  # install Robospect, suppress comments about being in detached HEAD state
  echo "pwd inside sing"
  pwd
  git clone https://github.com/czwa/robospect.py.git
  cd robospect.py
  git -c advice.detachedHead=false checkout tags/v0.77
  # record repo hash
  git log -1 --pretty
  mkdir tmp/
  python ./setup.py install --user
  cd ../rrlfe
  # record repo hash
  git log -1 --pretty

  # do a pip freeze
  #pip freeze --user > freeze_bad.txt

  # copy line list file
  cp ll ../robospect.py/tmp/

  # Run these lines in command line (replacing Singularity file name as needed)
  # export CODE_HOME=/afs/crc.nd.edu/user/e/espaldin/Private/rrlfe_work
  # [kludge for testing:] singularity exec roar.sif rm -v $CODE_HOME/rrlfe/src/model_spectra/rrmods_all/original_ascii_files/[5-6]*
  #
  # singularity exec --bind $CODE_HOME/rrlfe:/Users/bandari/Documents/git.repos/rrlfe,$CODE_HOME/robospect.py:/Users/bandari/Documents/git.repos/robospect.py roar.sif python $CODE_HOME/rrlfe/high_level_reduction_script.py
