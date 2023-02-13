Bootstrap: docker

From: tensorflow/tensorflow:2.11.0-gpu-jupyter

IncludeCmd: yes

%labels
Author Jason Chow
Version v2.00

%post
  apt-get update
  apt-get -y install wget nano ffmpeg

  # Update pip
  pip install --upgrade pip

  # Install easy stuff and dependencies for python 
  pip install tensorflow-addons tensorflow-datasets tensorflow-hub tensorflow_io pydub pandas numba


  
