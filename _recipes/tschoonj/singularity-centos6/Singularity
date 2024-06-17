Bootstrap: docker
From: centos:6

%post

# Deps
yum groupinstall -y 'Development Tools'

yum install -y wget glibc-devel.i686 libgcc.i686 libstdc++.i686 texinfo pcre-devel openssl-devel curl-devel mesa-libGL-devel

yum install -y libibverbs-devel

yum install -y zlib-devel

yum clean all -y

cd /usr/lib64
ls -l libOpenCL*
#ln -s libOpenCL.so.1.0.0 libOpenCL.so.1
ln -s libOpenCL.so.1.0.0 libOpenCL.so
ls -l libOpenCL*

%environment

# for Pymca
SPECFILE_USE_GNU_SOURCE=1
export SPECFILE_USE_GNU_SOURCE

%files
/usr/lib64/libOpenCL.so.1.0.0 /usr/lib64/
