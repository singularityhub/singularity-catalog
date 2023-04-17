bootstrap:docker
From:ubuntu:16.04

%post

# to find pip
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/usr/sbin:/bin:/sbin

apt-get update && apt-get upgrade -y --allow-unauthenticated

export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --allow-unauthenticated \
        build-essential \
        curl \
        dvipng \
        git \
        g++ \
        gcc \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        make \
        module-init-tools \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        openjdk-8-jdk \
        openjdk-8-jre-headless \
        texlive \
        texlive-latex-extra \
        vim \
        wget 

apt-get clean 
rm -rf /var/lib/apt/lists/*

curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        astropy \
        pyDOE \
        corner \
        emcee \
        memory_profiler \
        && \
    python -m ipykernel.kernelspec

# Install GSL
mkdir /gnu && \
wget -q https://ftp.gnu.org/gnu/gsl/gsl-2.4.tar.gz && \
tar -zxvf gsl-2.4.tar.gz && \
rm -f gsl-2.4.tar.gz && \
cd gsl-2.4 && \
./configure --prefix=/gnu/gsl > gsl_log 2>&1 && \
make >> gsl_log 2>&1 && \
make install >> gsl_log 2>&1

# Install fftw_float
mkdir ~/fftw_float && \
curl -O http://www.fftw.org/fftw-3.3.6-pl2.tar.gz && \
tar -zxvf fftw-3.3.6-pl2 && \
cd fftw-3.3.6-pl2 && \
./configure --enable-float  --enable-openmp --prefix=~/fftw_float && \
make && \
make install

# Download 21cmFAST and Set ENV Variables
git clone https://github.com/nkern/21cmFAST && \
chmod -R 777 21cmFAST

# Download env files
git clone https://github.com/nkern/21cmfast_env

# build info
echo "Timestamp:" `date --utc` | tee /image-build-info.txt

# Run bash
/bin/bash
