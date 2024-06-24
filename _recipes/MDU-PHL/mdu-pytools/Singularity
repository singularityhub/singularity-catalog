Bootstrap: docker
From: continuumio/miniconda3:4.6.14

%help
A Singularity image for name

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
name

%environment
export VERSION=version
export PATH=/opt/conda/bin:$PATH

%post
 # set versions of software to install
  export VERSION=version

  export PATH=/opt/conda/bin:$PATH

  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda

  echo "Sorting some env variables..."
  echo "All DBs updated on $(date "+%Y-%m-%d")" > /etc/dbupdate
  chmod 555 /etc/dbupdate

  echo "Done"

%runscript
  echo "Welcome to name ${VERSION}" >&2
  cat /etc/dbupdate >&2
  exec name "$@"

%test
  echo "Testing name"
