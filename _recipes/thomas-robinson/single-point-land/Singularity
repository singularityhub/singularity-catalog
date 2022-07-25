Bootstrap: localimage
From: /home/Thomas.Robinson/containers/intel/am4/spack_netcdf_intel.sif
Stage: devel

%files
### Transfer code from local to container
#   /home/Thomas.Robinson/containers/AM4_container/src /home/src
#   /home/Thomas.Robinson/containers/AM4_container/exec /home/exec

%post
## Set up environment
   . /opt/spack/share/spack/setup-env.sh
  spack load netcdf-c
  spack load netcdf-fortran
  spack load hdf5
  cd /home/exec
  mkdir /opt/hdf5
  ln -sf $(spack location -i hdf5)/include /opt/hdf5
### Compile code here
#  make  -j 8 OPENMP=on NETCDF=3 fms_cm4p12_xanadu_2020.03.x 
#  mkdir /opt/am4.xanadu_2020.03
#  cp fms_cm4p12_xanadu_2020.03.x /opt/am4.xanadu_2020.03/am4.xanadu_2020.03.x

#####################################
BootStrap: docker
From: centos:centos8
Stage: final

%files from devel
 
### Copy over executable
# /opt/am4.xanadu_2020.03/am4.xanadu_2020.03.x
 /opt/spack
 /opt/intel_oneapi/2021/compiler/2021.1.1

%post
yum install -y python3 which

%environment
### Add the executable to the path
 export PATH=:$PATH
 export KMP_STACKSIZE=512m
 export NC_BLKSZ=1M
 export F_UFMTENDIAN=big

%runscript
 ulimit -s unlimited
  . /opt/spack/share/spack/setup-env.sh
  spack load netcdf-c
  spack load netcdf-fortran
  spack load hdf5
### Run executable
# /opt/am4.xanadu_2020.03/am4.xanadu_2020.03.x
