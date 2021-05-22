Bootstrap: docker
From: ubuntu:bionic

%environment

PATH=/opt/conda/bin:$PATH
export PATH

%post
  
# Set up the PATH for other commands
export PATH=/opt/conda/bin:$PATH

# Update list of packages then upgrade them
apt-get update
apt-get install -y apt-utils 
DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
    
# Install basic packages
apt-get install -y --no-install-recommends build-essential cmake git curl vim \
    ca-certificates 
apt-get install -y screen terminator tmux vim wget 
apt-get install -y aptitude build-essential cmake g++ gfortran git pkg-config software-properties-common
apt-get install -y unrar
apt-get install -y libzip-dev

# Clean up
apt-get -y autoremove
rm -rvf /var/lib/apt/lists/*

# Install miniconda
cd /opt
curl -o /opt/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x /opt/miniconda.sh
/opt/miniconda.sh -b -p /opt/conda 
rm /opt/miniconda.sh

# Set locale in Singularity environment
echo 'export LC_ALL=C' >>$SINGULARITY_ENVIRONMENT
echo 'export PATH=/opt/conda/bin:$PATH' >>$SINGULARITY_ENVIRONMENT
