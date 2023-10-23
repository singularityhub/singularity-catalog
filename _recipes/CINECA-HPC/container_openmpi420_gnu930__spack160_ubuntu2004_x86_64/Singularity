Bootstrap: docker
From: ubuntu:20.04
IncludeCmd: yes

# IMPORTANT: When you are going to work inside the container remember to source these 2 file in order to set the proper module environment with spack and Lmod
# source /opt/spack/share/spack/setup-env.sh && source /usr/share/lmod/6.6/init/sh


%post

export DEBIAN_FRONTEND=noninteractive

apt-get -yqq update 
apt-get -yqq install --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        file \
        g++ \
        gcc \
        gfortran \
        git \
        gnupg2 \
        iproute2 \
        lmod \
        locales \
        lua-posix \
        make \
        python3 \
        python3-pip \
        python3-setuptools \
        tcl \
        unzip 

locale-gen en_US.UTF-8 

pip3 install boto3
rm -rf /var/lib/apt/lists/*

# INSTALL SPACK

cd /opt 
git clone https://github.com/spack/spack.git
cd spack
git checkout tags/v0.16.0

# SPACK ENVIRONMENT

export SPACK_ROOT=/opt/spack
export PATH=${SPACK_ROOT}/bin:$PATH
export MODULEPATH=/opt/spack/opt/spack/linux-ubuntu20.04-skylake/gcc-9.3.0

cat > /opt/spack/etc/spack/defaults/linux/compilers.yaml <<EOF
compilers:
- compiler:
    spec: gcc@9.3.0
    paths:
      cc: /bin/gcc
      cxx: /bin/g++
      f77: /bin/gfortran
      fc: /bin/gfortran
    flags: {}
    operating_system: ubuntu20.04
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
EOF

spack install openmpi@4.0.2 %gcc@9.3.0 fabrics=psm2,verbs,ofi +pmi +legacylaunchers schedulers=slurm ^slurm@20-02-4-1 ^python@3.6.4

spack gc -y

# ADDITIONAL FILES TO HANDLE ENVIRONMENT VARIABLES

cat > /opt/load_module_spack_env.txt <<EOF
#!/bin/bash
# INSTRUCTIONS: source /opt/load_module_spack_env.txt

source /opt/spack/share/spack/setup-env.sh
source /usr/share/lmod/6.6/init/sh
EOF

cat > /opt/snapshot_env.sh <<EOF
#!/bin/bash
# INSTRUCTIONS: /opt/snapshot_env.sh

rm -f \$SINGULARITY_ENVIRONMENT
touch \$SINGULARITY_ENVIRONMENT
echo "# PART KEEP FIXED" >> \$SINGULARITY_ENVIRONMENT
echo "export TMPDIR=\`echo \$TMPDIR\`" >> \$SINGULARITY_ENVIRONMENT
echo "export TMP=\`echo \$TMP\`" >> \$SINGULARITY_ENVIRONMENT
echo "export SPACK_ROOT=\`echo \$SPACK_ROOT\`" >> \$SINGULARITY_ENVIRONMENT
echo "export PATH=\`echo \$PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export LMOD_CMD=\`echo \$LMOD_CMD\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MODULEPATH=\`echo \$MODULEPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "# PART TO CHANGE" >> \$SINGULARITY_ENVIRONMENT
echo "export LIBRARY_PATH=\`echo \$LIBRARY_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export LD_LIBRARY_PATH=\`echo \$LD_LIBRARY_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CPATH=\`echo \$CPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export INCLUDE=\`echo \$INCLUDE\`" >> \$SINGULARITY_ENVIRONMENT
echo "export C_INCLUDE_PATH=\`echo \$C_INCLUDE_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CPLUS_INCLUDE_PATH=\`echo \$CPLUS_INCLUDE_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CC=\`echo \$CC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export FC=\`echo \$FC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export F77=\`echo \$F77\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CXX=\`echo \$CXX\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CUDA_HOME=\`echo \$CUDA_HOME\`" >> \$SINGULARITY_ENVIRONMENT
echo "export cuDNN_ROOT=\`echo \$cuDNN_ROOT\`" >> \$SINGULARITY_ENVIRONMENT
echo "export PYTHONPATH=\`echo \$PYTHONPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CMAKE_PREFIX_PATH=\`echo \$CMAKE_PREFIX_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MANPATH=\`echo \$MANPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPICC=\`echo \$MPICC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPICXX=\`echo \$MPICXX\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPIF90=\`echo \$MPIF90\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPIF77=\`echo \$MPIF77\`" >> \$SINGULARITY_ENVIRONMENT
EOF

chmod a+x /opt/snapshot_env.sh

cat > /opt/script_add_environment.py <<EOF
import glob
import os

ompi_path = glob.glob("/opt/spack/opt/spack/linux-*/gcc-*/openmpi*")[0]
mod_path = glob.glob("/opt/spack/opt/spack/linux-*/gcc-*")[0]
envfile = os.environ["SINGULARITY_ENVIRONMENT"]
with open(envfile, "a") as f:
    f.write("export PATH={}/bin:$PATH\n".format(ompi_path))
    f.write("export LD_LIBRARY_PATH={}/lib:$LD_LIBRARY_PATH\n".format(ompi_path))
    f.write("export MODULEPATH={}\n".format(mod_path))

EOF

python3 /opt/script_add_environment.py


%environment

export SPACK_ROOT=/opt/spack
export LMOD_CMD=/usr/share/lmod/lmod/libexec/lmod
