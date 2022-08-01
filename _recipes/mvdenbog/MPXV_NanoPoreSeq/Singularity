Bootstrap: docker
From: mvdenbog/centos83_barebones

%post

# install python38 dependencies:
pip38 install -r pip38_installed_packages.txt

# install conda base env dependencies:
conda install -n base conda_installed_packages_base.txt

# conda :

cd /opt/ ; \
curl -fsSL --retry 5 -o Miniconda3-py38_4.8.2-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh
bash Miniconda3-py38_4.8.2-Linux-x86_64.sh -b -p /opt/Conda/

# canu :

cd /opt/
wget https://github.com/marbl/canu/releases/download/v1.8/canu-1.8.Linux-amd64.tar.xz
xz -d canu-1.8.Linux-amd64.tar.xz
tar xf canu-1.8.Linux-amd64.tar

# homopolish:
## install conda homopolish env dependencies
conda install -n homopolish conda_installed_packages_homopolish.txt

## homopolish from git:
cd /opt/
git clone https://github.com/ythuang0522/homopolish.git
cd homopolish 
conda env create -f environment.yml
conda activate homopolish
cd /opt/homopolish/
wget http://bioinfo.cs.ccu.edu.tw/bioinfo/mash_sketches/virus.msh.gz
gunzip virus.msh.gz

# fastmer (is a python2 tool) :

dnf install python2 python2-devel numpy pysam 

conda deactivate
pip2 install numpy
cd /opt/
mkdir FastMer
cd /opt/FastMer/
wget https://raw.githubusercontent.com/jts/assembly_accuracy/master/fastmer.py

# Environments:

## conda
echo "export PATH+=:/opt/Conda/bin/" | tee -a /environment
## canu 
echo "export PATH+=:/opt/canu-1.8/Linux-amd64/bin/" | tee -a /etc/environment

