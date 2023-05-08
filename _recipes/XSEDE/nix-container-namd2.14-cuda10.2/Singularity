Bootstrap: docker
From: xsede/nix-namd2-14-cuda10.2:latest
# The above container does not yet exist in a public repo - for now
#  replace this with a reference to the one built locally from the included
#  Dockerfile.

%runscript
#Simply pass any commandline arguments to namd2
/usr/bin/namd2 $@

%help
 This contains NAMD 2.14 built with CUDA 10.2.89 support.
