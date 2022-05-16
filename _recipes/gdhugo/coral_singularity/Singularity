Bootstrap: docker
From: tensorflow/tensorflow:1.12.0-gpu-py3

# adapted from: https://github.com/marcc-hpc/tensorflow

%environment
  # use bash as default shell
  SHELL=/bin/bash
  export SHELL
  export HDF5_USE_FILE_LOCKING='FALSE'

%setup
  # runs on host
  # the path to the image is $SINGULARITY_ROOTFS

%post
  # post-setup script

  # load environment variables
  . /environment

  # use bash as default shell
  echo 'SHELL=/bin/bash' >> /environment

  # make environment file executable
  chmod +x /environment

  # default mount paths
  mkdir /scratch

  # fix this issue: https://github.com/singularityware/singularity/issues/1182#issuecomment-381796545
  touch /usr/bin/nvidia-smi

  # keras - still use standalone keras, rather than tf.keras

  apt-get update && apt-get -y install locales
  locale-gen en_US.UTF-8
  apt-get install -y git wget
  # python3-dev python3-pip python3-tk
  apt-get clean

  # pandas
  apt-get install python3-pandas

  # apt-get install -y libcupti-dev
  # pip3 install --upgrade
  # pip3 install keras

%runscript
  # executes with the singularity run command
  # delete this section to use existing docker ENTRYPOINT command

%test
  # test that script is a success
