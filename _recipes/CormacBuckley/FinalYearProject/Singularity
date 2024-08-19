Bootstrap: docker
From: tensorflow/tensorflow:1.9.0-gpu-py3

%environment
  # use bash as default shell
  SHELL=/bin/bash
  export SHELL

%setup
  # runs on host - the path to the image is $SINGULARITY_ROOTFS

%post
  # post-setup script

  # load environment variables
  . /environment

  # use bash as default shell
  echo 'SHELL=/bin/bash' >> /environment

  # make environment file executable
  chmod +x /environment

  # default mount paths
  mkdir /scratch /data 

  # additional packages
  apt-get update
  apt-get install -y python-tk
  apt-get install -y libsm6 libxext6 
  apt-get install -y python3-numpy python3-scipy
  apt-get install -y python3-pil
  apt-get install -y libhdf5-dev
  apt-get install -y python3-matplotlib
  apt-get install -y build-essential cython3
  apt-get install -y python3-pip python3-dev build-essential 
  pip install Keras==2.1.3
  pip install opencv-python
  apt-get install -y libatlas-base-dev
  apt-get install -y libjasper-dev
  apt-get install -y libqtgui4
  apt-get install -y python3-pyqt5
  apt-get install -y libqt4-test
  pip install scikit-image
  pip install imageio Shapely six
  pip install imgaug 

%runscript
  # executes with the singularity run command
  # delete this section to use existing docker ENTRYPOINT command

%test
  # test that script is a success