BootStrap: docker
From: library/debian@sha256:edb0a5915350ee6e2fedd8f9d0fe2e7f956f7a58f7f41b5e836e0bb7543e48a1

%files

  ./checksum.txt /root/checksum.txt
  ./Makefile /root/Makefile
  ./swat_code_mods.patch /root/swat_code_mods.patch
  
%post
  mkdir /root/build
  mkdir /usr/local/swat681
  mv /root/checksum.txt /root/Makefile /root/swat_code_mods.patch /root/build

  apt update
  apt install -y gcc-9 \
                 gfortran-9 \
                 dos2unix \
                 unzip \
                 wget \
                 make \
                 patch

#Interactive tools for testing - comment/uncomment as needed!
#  apt install -y vim \
#                 strace \
#                 lsof 

  wget -O /root/build/rev_681_source.zip https://swat.tamu.edu/media/116557/rev681_source.zip
  cd /root/build 
  md5sum checksum.txt 
  unzip rev_681_source.zip 

  cd /root/build/
  dos2unix * 
  patch -p0 < swat_code_mods.patch 
  make debug64 
  cp swat_debug64 /usr/local/swat681/swat

# SWAT is a bit unusual in that it requires input files reside in the same directory as the executable!
#  So, we're putting the final binary in an unusual place to avoid mounting problems


%runscript
  /usr/local/swat681/swat

%help
 This container includes the Soil and Water Assessment Tool (https://swat.tamu.edu/software/)
 revision 681,
 built for use on amd64 Linux systems. The binary is installed at /usr/local/swat681/swat.
 At run-time, any input files MUST be bind-mounted to /usr/local/swat681 - for example:
