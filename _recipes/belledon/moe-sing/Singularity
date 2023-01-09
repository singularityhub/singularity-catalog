Bootstrap: docker
From: ubuntu:16.04

%post
  apt-get update && apt-get -y install locales
  locale-gen en_US.UTF-8
  apt-get install -y  python python-dev gcc cmake \
                      libboost-all-dev python-pip doxygen \
                      libblas-dev liblapack-dev gfortran \
                      git python-numpy python-scipy

  apt-get clean
  
  export MOE_CC_PATH="$(which gcc)"
  export MOE_CXX_PATH="$(which g++)"
  export MOE_CMAKE_OPTS="-D MOE_PYTHON_INCLUDE_DIR=/usr/include/python2.7 -D MOE_PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0"

  cd /
  mkdir /moe && cd /moe
  git clone https://github.com/wujian16/Cornell-MOE.git
  cd Cornell-MOE
  pip install -r requirements.txt
  python setup.py install
