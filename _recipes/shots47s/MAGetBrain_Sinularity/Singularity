Bootstrap: shub
From: vfonov/minc-toolkit-containers:1.0.09

###########################################################
#                                                         #
# MCIN (McGill Centre for Integrative Neuroscience)       #
#                                                         #
# Singularity recipe for MAGeTbrain to build a container  #
# used in CBRAIN (https://github.com/aces/cbrain)         #
#                                                         #
###########################################################

%labels
  Maintainer Natacha Beck

%help
This container provides MAGeTbrain
(Multiple Automatically Generated Templates brain segmentation algorithm).

%post
  apt-get update  -y
  apt-get install -y automake
  apt-get install -y build-essential 
  apt-get install -y curl
  apt-get install -y git
  apt-get install -y libnetcdf-dev  
  apt-get install -y libhdf5-dev
  apt-get install -y parallel
  apt-get install -y vim

  curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
  python get-pip.py 
  pip install pyminc scipy
  pip install qbatch 
  pip install future

  git clone --recursive https://github.com/Mouse-Imaging-Centre/minc-stuffs.git /minc-stuffs && \
  cd /minc-stuffs                                                                            && \
  ./autogen.sh                                                                                 && \
  ./configure --prefix=/opt CPPFLAGS="-I/usr/include/hdf5/serial -I/opt/minc/1.0.09/include" LDFLAGS="-L/opt/minc/1.0.09/lib -L/usr/lib/hdf5/serial" &&\
  make                                                                                       && \
  make install                                                                               && \
  python setup.py install

  # Clone MAGeTbrain 
  cd /opt
  git clone https://github.com/CobraLab/MAGeTbrain.git 
  #source /opt/MAGeTbrain/bin/activate

%environment
  PATH=/opt/MAGeTbrain/bin:$PATH

%runscript

exec "/bin/bash -c 'source /opt/MAGeTbrain/bin/activate; $@"
