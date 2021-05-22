Bootstrap: debootstrap
OSVersion: focal
MirrorURL: http://archive.ubuntu.com/ubuntu/

%post
  sed -i 's/main/main restricted universe/g' /etc/apt/sources.list
  apt-get update
  # Install R, Python, misc. utilities
  apt-get install -y libopenblas-dev libcurl4-openssl-dev libopenmpi-dev openmpi-bin openmpi-common openmpi-doc openssh-client openssh-server 
  
  apt install -y wget build-essential git vim
  apt install -y libmetis-dev libtbb-dev libfftw3-dev lib32gcc-7-dev libflann-dev libcilkrts5

  apt install -y curl vim git libhdf5-dev
  apt install -y libssl-dev libxml2-dev python3-pip python3-igraph

  apt install -y nodejsi cmake

  ## next is important for python tsne
  apt-get install libatlas-base-dev

  apt-get clean


  pip3 install --upgrade pip
  pip3 install --no-cache-dir -U numpy pybind11
  pip3 install --no-cache-dir -U dask[array] dask[distributed]

  pip3 install git+https://github.com/fraenkel-lab/pcst_fast.git
  pip3 install jupyterlab ipython-autotime
  
  pip3 install Sphinx sphinx-autodoc-typehints nbsphinx sphinx_rtd_theme

  pip3 install dask[array] dask[distributed]
  pip3 install 'fsspec>=0.3.3'
  pip3 install -U "dask[dataframe]"

  #pip install git+https://github.com/parashardhapola/scarf.git
  #untill this is not public mount the local git filder under /mnt/git and
  # e.g. singularity build --fakeroot -b~/git:/mnt/git ubuntu::latest Singularity
  cd /mnt/git/scarf && pip install -U .


  pip3 install scanpy[louvain]
  pip3 install scanpy[leiden]

  pip3 install igraph
  pip3 install phate

  pip3 install scvelo

  pip3 install harmonypy
  pip3 install mnnpy
  pip3 install bbknn

  pip3 install palantir
  pip3 install trimap
  pip3 install sam
  pip3 install tsne

  pip3 install pybind11 hnswlib

  ## record memory usage over time.
  ## procpath record -i 1 -r 120 -d ff.sqlite
  ## procpath plot -d ff.sqlite -q cpu -p 123 -f cpu.svg
  ## procpath plot -d ff.sqlite -q rss -p 123 -f rss.svg

  pip3 install --user procpath


  pip3 install cellphonedb

  ## the templates funnily are root read only and hence unusable
  chmod 777 -R  /usr/share/jupyter/nbconvert/templates/

  # Install R
  deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/  
  apt update
  apt install -y r-base r-base-dev

  echo "install.packages('devtools')" > Install_devtools.R
  R CMD BATCH Install_devtools.R

  echo "install.packages('Seurat')" > Install_Seurat.R
  R CMD BATCH Install_Seurat.R

  echo "devtools::install_github('sonejilab/cellexalvrR', ref='V_0.14')" > Install_cellexalvrR.R
  R CMD BATCH Install_cellexalvrR.R

  echo "devtools::install_github('satijalab/seurat-data')" > Install_seurat-data.R
  R CMD BATCH Install_seurat-data.R

  # skip that as it would need rgl to be installed
  #  echo "devtools::install_github('stela2502/BioData')" > Install_BioData.R
  #  R CMD BATCH Install_BioData.R

  echo 'devtools::install_github("IRkernel/IRkernel")' > Install_IRkernel.R
  echo 'IRkernel::installspec(user=FALSE)' >> Install_IRkernel.R
  R CMD BATCH Install_IRkernel.R

  mkdir /workspace
  echo "jupyter lab --port 9734 --ip=0.0.0.0 --allow-root --no-browser" > /workspace/launch_jupyter.sh
  chmod +x /workspace/launch_jupyter.sh

%runscript
  /workspace/launch_jupyter.sh


