Bootstrap: docker-daemon
From: jec/namd3-nocuda:latest

%post
yum install -y which strace

%runscript
#By default, pass in cmdline args to namd3
  echo "${@}" | /usr/bin/namd3

%help
 This container will run NAMD3.0 alpha single-node multi-gpu
