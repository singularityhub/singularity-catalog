Bootstrap: docker
From: centos:centos7.6.1810
IncludeCmd: yes

# IMPORTANT: When you are going to work inside the container remember to source these 2 file in order to set the proper module environment with spack and Lmod
# source /opt/spack/share/spack/setup-env.sh && source /usr/share/lmod/8.2.7/init/sh

%post

mkdir /tmp_locale
chmod 777 -R /tmp_locale
export TMPDIR=/tmp_locale
export TMP=/tmp_locale

yum -y install epel-release
yum -y groupinstall "Development tools"
yum install -y c-ares c-ares-devel Lmod python36
yum install -y  bzip2  gzip tar  zip unzip xz curl wget vim patch make cmake file git which perl-Data-Dumper perl-Thread-Queue boost-devel
yum install -y numactl-libs gtk2 atk cairo tcsh lsof ethtool tk pciutils libnl3 libmnl libudev-devel


# INSTALL MELLANOX

cd /opt
wget https://b2drop.eudat.eu/s/xM8dSwEXDXj64Xn/download -O MLNX_OFED_LINUX-4.7-3.2.9.1-rhel7.6alternate-ppc64le.tar.gz
tar xzvf MLNX_OFED_LINUX-4.7-3.2.9.1-rhel7.6alternate-ppc64le.tar.gz
cd MLNX_OFED_LINUX-4.7-3.2.9.1-rhel7.6alternate-ppc64le
./mlnxofedinstall --force --without-32bit --without-fw-update --user-space-only
cd /opt 
rm -rf MLNX_OFED_LINUX-4.7-3.2.9.1-rhel7.6alternate-ppc64le.tar.gz MLNX_OFED_LINUX-4.7-3.2.9.1-rhel7.6alternate-ppc64le


# INSTALL CUDA DRIVERS

cd /opt
wget https://b2drop.eudat.eu/s/Xd9YmJd9ZQzKwM2/download -O cuda_driver_m100.tar.gz
tar xvf cuda_driver_m100.tar.gz
yum -c /opt/nvidia-driver-local-repo-440.64.00/etc/yum.repos.d/nvidia-driver-local-440.64.00.repo install -y cuda-drivers
rm -f cuda_driver_m100.tar.gz

# INSTALL SPACK

cd /opt 
git clone https://github.com/spack/spack.git
cd spack
git checkout tags/v0.16.0

# SPACK ENVIRONMENT

export SPACK_ROOT=/opt/spack
export PATH=${SPACK_ROOT}/bin:$PATH
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos7-power8le:/opt/spack/share/spack/modules/linux-centos7-power9le

spack --version

# INSTALL GNU 8.4.0 WITH SPACK 

cat > /opt/spack/etc/spack/defaults/linux/compilers.yaml <<EOF
compilers:
- compiler:
    spec: gcc@4.8.5
    paths:
      cc: /bin/gcc
      cxx: /bin/g++
      f77: /bin/gfortran
      fc: /bin/gfortran
    flags: {}
    operating_system: centos7
    target: ppc64le
    modules: []
    environment: {}
    extra_rpaths: []
EOF

spack install gcc@8.4.0 %gcc@4.8.5

cat >> /opt/spack/etc/spack/defaults/linux/compilers.yaml <<EOF
- compiler:
    spec: gcc@8.4.0
    paths:
      cc: /opt/spack/opt/spack/linux-centos7-power8le/gcc-4.8.5/gcc-8.4.0-xbxiviire7czb5w5a3ucs45ok73v7gnu/bin/gcc
      cxx: /opt/spack/opt/spack/linux-centos7-power8le/gcc-4.8.5/gcc-8.4.0-xbxiviire7czb5w5a3ucs45ok73v7gnu/bin/g++
      f77: /opt/spack/opt/spack/linux-centos7-power8le/gcc-4.8.5/gcc-8.4.0-xbxiviire7czb5w5a3ucs45ok73v7gnu/bin/gfortran
      fc: /opt/spack/opt/spack/linux-centos7-power8le/gcc-4.8.5/gcc-8.4.0-xbxiviire7czb5w5a3ucs45ok73v7gnu/bin/gfortran
    flags: {}
    operating_system: centos7
    target: ppc64le
    modules: []
    environment: {}
    extra_rpaths: []
EOF

# LINK EXTERNAL SOFTWARE WITH SPACK hcoll and mxm

cat >> /opt/spack/etc/spack/defaults/packages.yaml <<EOF
  hcoll:
    externals:
    - prefix: /opt/mellanox/hcoll
      spec: hcoll@m100
  mxm:
    externals:
    - prefix: /opt/mellanox/mxm
      spec: mxm@m100
EOF

spack gc -y

# ADDITIONAL FILES TO HANDLE ENVIRONMENT VARIABLES

cat > /opt/load_module_spack_env.txt <<EOF
#!/bin/bash
# INSTRUCTIONS: source /opt/load_module_spack_env.txt

source /opt/spack/share/spack/setup-env.sh
source /usr/share/lmod/8.2.7/init/sh
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

%environment

export TMPDIR=/tmp_locale
export TMP=/tmp_locale
export SPACK_ROOT=/opt/spack
export PATH=/usr/share/lmod/8.2.7/libexec/lmod:${SPACK_ROOT}/bin:$PATH
export LMOD_CMD=/usr/share/lmod/8.2.7/libexec/lmod
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos7-power8le:/opt/spack/share/spack/modules/linux-centos7-power9le

