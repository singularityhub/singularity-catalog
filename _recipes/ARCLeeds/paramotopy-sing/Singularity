Bootstrap: docker
From: ubuntu:18.04

%post

######### download and install Bertini v1.6
apt-get update
apt-get install -yq openssh-server wget gnupg libmpfr-dev python \
                    build-essential libgmp3-dev bison libboost-all-dev \
                    libgmp3-dev mpich flex git autotools-dev autoconf
wget https://bertini.nd.edu/BertiniSource_v1.6.tar.gz
tar -xzf BertiniSource_v1.6.tar.gz --no-same-owner
chmod -R 775 BertiniSource_v16

cd BertiniSource_v16
mkdir install
./configure
make && make install

cd / 

########### download and install paramotopy
git clone https://github.com/ofloveandhate/paramotopy.git

cd paramotopy
libtoolize && autoreconf -vfi
mkdir install
./configure 
make && make install

%environment

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

%runscript

    # if the length of command line arguments is 0
    if [ $1 = "help" ]; then
    printf "This container provides the following executables:\n"
    ls /usr/local/bin
    else
    exec "/usr/local/bin/$@"
    fi