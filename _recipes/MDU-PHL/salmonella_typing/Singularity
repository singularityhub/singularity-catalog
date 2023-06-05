Bootstrap: docker
From: continuumio/miniconda3:4.6.14

%help
A Singularity image for sistr

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
sistr

%environment
export SISTR_VERSION=1.1.0
export PYTHONNOUSERSITE=NO
export PYTHONPATH=/opt/salmonella_typing
export PATH=/opt/conda/bin:/opt/salmonella_typing:$PATH

%setup
  PY_VERSION=3.7
  SISTR_VERSION=1.1.0
  cp -R salmonella_typing $SINGULARITY_ROOTFS/opt/salmonella_typing

%files
sistrdb.tar.gz

%post
 # set versions of software to install
  SISTR_VERSION=1.1.1
  SISTR_BUILD=py37_3

  apt-get update && apt-get install --yes subversion

  export PATH=/opt/conda/bin:/opt/salmonella_typing:$PATH
  export PYTHONNOUSERSITE=NO
  export PYTHONPATH=/opt/salmonella_typing

  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda

  conda install sistr_cmd=1.1.1 cleo=0.6.8 pandas=0.24.2 xlsxwriter=1.2.8 tabulate=0.8.7 sh=1.12.14 pytest=4.6.3 jinja2=2.11.1 nextflow
 
  cd / && tar xvzf sistrdb.tar.gz && rm sistrdb.tar.gz

  echo "Sorting some env variables..."
  chmod 755 /opt/salmonella_typing/stype_cli.py

  echo "Done"

%runscript
  echo "Welcome to MDU SALMONELLA TYPING WORKFLOW" >&2
  echo "Running sistr version $VERSION" >&2
  echo $DB_UPDATE >&2
  exec stype_cli.py "$@"

%test
  export PYTHONNOUSERSITE=NO
  export PYTHONPATH=/opt/salmonella_typing
  export PATH=/opt/conda/bin:/opt/salmonella_typing:$PATH

  echo "Testing sistr"
  stype_cli.py test -vvv

