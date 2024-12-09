Bootstrap: docker
From: ubuntu:18.04


%environment
# setup PATH to point to julia, conda, and blender
export PATH=$PATH:/julia/bin
export PATH=$PATH:/miniconda/bin
export PATH=$PATH:/blender
export LANG=en_US.UTF-8

%runscript
  exec bash "$@"

%post

# System level packages
apt-get update
apt-get install -y  build-essential \
                    graphviz \
                    git \
                    wget \
                    ffmpeg \
                    libglu1 \
                    libxi6
apt-get clean

# Build context
mkdir /build-ctx && cd /build-ctx

# Setup blender
wget "https://yale.box.com/shared/static/nn6n5iyo5m4tzl5u9yoy2dvv1ohk22xj.xz" \
    -O blender.tar.gz
tar -xf blender.tar.gz
mv blender-2.* /blender
chmod +x /blender/blender


# Setup conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
bash conda.sh -b -p /miniconda

# Add an sbatch workaround
echo '#!/bin/bash\nssh -y "$HOSTNAME"  sbatch "$@"'  > /usr/bin/sbatch
chmod +x /usr/bin/sbatch

# Add an scancel workaround
echo '#!/bin/bash\nssh -y "$HOSTNAME"  scancel "$@"'  > /usr/bin/scancel
chmod +x /usr/bin/scancel

# Add an srun workaround
echo '#!/bin/bash\nssh -y "$HOSTNAME"  srun "$@"'  > /usr/bin/srun
chmod +x /usr/bin/srun

# clean up
rm -rf /build-ctx
