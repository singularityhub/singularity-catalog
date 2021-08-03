################################################################################
# Basic bootstrap definition to build Ubuntu container from Docker container
################################################################################

Bootstrap:docker
From:ubuntu:latest

%labels
Maintainer Matthew Andres Moreno
Version 0.0.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files
. /opt/tag-olympics

%post
################################################################################
# Install additional packages
################################################################################
apt-get update

apt-get install -y software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get install -y build-essential
apt-get install -y gcc-8 g++-8

apt-get install -y git
apt-get install -y make
apt-get install -y python3
apt-get install -y python3-pip

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 10
update-alternatives --set g++ "/usr/bin/g++-8"

pip3 install numpy
pip3 install matplotlib
pip3 install pandas
pip3 install seaborn
pip3 install networkx
pip3 install keyname
pip3 install fileshash

git clone https://github.com/devosoft/Empirical /opt/Empirical -b match-bin

chmod 777 -R /opt

cd /opt/tag-olympics && make static && cd ..

ln -s /opt/tag-olympics/low-tag-olympics /usr/bin/
ln -s /opt/tag-olympics/mid-tag-olympics /usr/bin/

################################################################################
# Run the user's login shell, or a user specified command
################################################################################
%runscript
echo "Nothing here but us birds!"
