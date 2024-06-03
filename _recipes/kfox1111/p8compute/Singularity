Bootstrap: docker
From: pnnlhep/p8compute:latest

%files
project8-cvmfs.tar /tmp
gcc.tar.gz /tmp
DIRAC-lcg-2016-11-03-Linux_x86_64_glibc-2.12-python27.tar.gz /pic/projects/project8/dirac-jobs/cache/
DIRAC-v6r17p7.tar.gz /pic/projects/project8/dirac-jobs/cache/
Externals-client-v6r5p4-Linux_x86_64_glibc-2.12-python27.tar.gz /pic/projects/project8/dirac-jobs/cache/

%post
mkdir -p /cvmfs/hep.pnnl.gov/project8
cd /cvmfs/hep.pnnl.gov/project8
tar -xvf /tmp/project8-cvmfs.tar
rm /tmp/project8-cvmfs.tar
cd /
tar -zxvf /tmp/gcc.tar.gz
rm /tmp/gcc.tar.gz
