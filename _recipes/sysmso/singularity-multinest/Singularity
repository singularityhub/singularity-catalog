Bootstrap: docker
From: ubuntu:latest

%files
pymultinest_demo_minimal.py /pymultinest_demo_minimal.py

%labels
AUTHOR souchal@apc.in2p3.fr
version 1.0

%environment
LD_LIBRARY_PATH=/usr/local/lib/
export LD_LIBRARY_PATH

%post
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install python software-properties-common wget build-essential sgml-base rsync xml-core openssh-client python-dev
add-apt-repository universe
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install cmake git gfortran openmpi-common openmpi-bin libopenmpi-dev liblapack-dev
apt-get clean
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python get-pip.py
ln -s /usr/local/bin/pip /usr/bin/pip
pip install pymultinest ipython scipy numpy matplotlib progressbar
mkdir /data
git clone https://github.com/JohannesBuchner/MultiNest.git
cd MultiNest/build/
cmake ..
make
make install
mkdir /scratch
chmod -R 777 /scratch

%runscript
python /pymultinest_demo_minimal.py
