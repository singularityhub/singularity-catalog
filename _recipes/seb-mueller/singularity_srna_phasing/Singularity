Bootstrap: docker
From: continuumio/miniconda3:4.7.12

%labels
AUTHOR sebmu@posteo.de
Version v1.0

%environment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This sets global environment variables for anything run within the container
export PATH="/opt/conda/bin:/usr/local/bin:/usr/bin:/bin:"
unset CONDA_DEFAULT_ENV
export ANACONDA_HOME=/opt/conda

%files
  # copies local file into /
  phasetank.yaml

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is going to be executed after the base container has been downloaded
wget 'https://sourceforge.net/projects/phasetank/files/PhaseTank_V1.0_BETE/PhaseTank_v1.0.tar.gz/download'
tar xvzf download
cd PhaseTank_v1.0
PATH=$PATH:PhaseTank_v1.0:$PATH

# apt-get update

export PATH=/opt/conda/bin:$PATH
# conda update conda
# conda config --set ssl_verify false
conda config --set ssl_verify /opt/conda/ssl/cacert.pem
conda env update -n base --file /phasetank.yaml
# conda init bash
# bash
# conda activate base

conda clean --index-cache --tarballs --packages --yes
# pip install snakemake


# save a list of all installed packages within the container
conda list > conda_list_packages.txt
pip list > pip_list_packages.txt

#clean up
apt-get -y remove --auto-remove gcc
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean
