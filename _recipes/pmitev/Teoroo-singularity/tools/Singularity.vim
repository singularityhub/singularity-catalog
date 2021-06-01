/home/pmitev/Singularity/vim/Singularity                                                                                                        149/149               100%
Bootstrap:  docker
From: thinca/vim:latest-full

%runscript
  vim $*

%setup

%files

%environment

%post
