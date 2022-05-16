BootStrap: docker
From: library/debian@sha256:edb0a5915350ee6e2fedd8f9d0fe2e7f956f7a58f7f41b5e836e0bb7543e48a1

%post
  mkdir /root/build
  mkdir /root/build/swat_rev681_WRs
  mkdir /usr/local/swat681

  apt update
  apt install -y gcc-9 \
                 gfortran-9 \
                 dos2unix \
                 unzip \
                 wget \
		 git \
                 make \
                 patch

#Interactive tools for testing - comment/uncomment as needed!
#  apt install -y vim \
#                 strace \
#                 lsof 

  cd /root/build/swat_rev681_WRs
  git init
  git pull https://github.com/Hydroinformatics/InterACTWEL.git swat_rev681_WRs 
  dos2unix * 
  make rel64 
  cp swat_rel64 /usr/local/swat681/swat

# SWAT is a bit unusual in that it requires input files reside in the same directory as the executable!
#  So, we're putting the final binary in an unusual place to avoid mounting problems


%runscript
  /usr/local/swat681/swat

%help
 This container includes the Soil and Water Assessment Tool (https://swat.tamu.edu/software/)
 revision 681,
 built for use on amd64 Linux systems. The binary is installed at /usr/local/swat681/swat.
 At run-time, any input files MUST be bind-mounted to /usr/local/swat681 - for example:
