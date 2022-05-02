Bootstrap: docker
From: continuumio/miniconda

%post
apt-get --allow-releaseinfo-change update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade  && \
DEBIAN_FRONTEND=noninteractive apt-get -y install \
	libxxf86vm1
conda update conda && conda update --all
conda create -n cryolo -c conda-forge -c anaconda pyqt=5 python=3 numpy==1.18.5 libtiff wxPython=4.1.1  adwaita-icon-theme
eval "$(conda shell.bash hook)"
conda activate cryolo
pip install nvidia-pyindex
pip install 'cryolo[c11]'

%runscript
echo 'run me with:'
echo 'singularity shell -B /run --nv container.sif'
echo 'To initialise cryolo environment inside conda inside the container:'
echo 'eval "$(/opt/conda/bin/conda shell.bash hook)"'
echo 'conda activate cryolo'
