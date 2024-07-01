bootstrap:docker
from:continuumio/miniconda

%labels
MAINTAINER Yasasvy Nanyam ynanyam@iastate.edu

%post
apt-get update
apt-get install -y gcc libgl1-mesa-glx
export PATH=/opt/conda/bin:$PATH
conda config --add channels conda-forge
conda config --add channels bioconda
conda install bamm 
pip install --no-cache-dir cython GroopM pillow refinem 
ln -s /opt/conda/lib/libhts.so /opt/conda/lib/libhts.so.1
conda install checkm-genome
conda install functools_lru_cache
echo 'export PATH=/usr/local/bin:/opt/conda/bin:$PATH' >>$SINGULARITY_ENVIRONMENT
# INSTALL PRODIGAL
apt-get update
apt-get install -y build-essential
cd /opt
git clone https://github.com/hyattpd/Prodigal.git
cd Prodigal
make install
cd ..
rm -rf Prodigal
#INSTALL BLAST+
apt install -y ncbi-blast+
# INSTALL DIAMOND
cd /opt
wget http://github.com/bbuchfink/diamond/releases/download/v0.9.22/diamond-linux64.tar.gz
tar xzf diamond-linux64.tar.gz
mv diamond /usr/local/bin
cd ..
rm -rf /var/lib/apt/lists/*
# Install Krona
cd /opt
wget https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar
tar xf KronaTools-2.7.tar
cd KronaTools-2.7
./install.pl
