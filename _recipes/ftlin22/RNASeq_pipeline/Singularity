Bootstrap: docker
From: ubuntu:14.04

%labels
MAINTAINER vanessasaur
WHATAMI dinosaur

%environment
DINOSAUR=vanessasaurus
export DINOSAUR

%files
hello.sh /hello.sh

%post
chmod u+x /hello.sh

%runscript
exec /bin/bash /hello.sh
© 2021 GitHub, Inc.
Terms
Privacy
