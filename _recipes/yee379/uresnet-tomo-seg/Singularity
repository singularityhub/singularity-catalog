bootstrap: docker
from: tensorflow/tensorflow:1.11.0-gpu-py3

%post

apt-get install -y git

pip install iotools

cd /opt/
git clone https://github.com/DeepLearnPhysics/dynamic-gcnn.git
