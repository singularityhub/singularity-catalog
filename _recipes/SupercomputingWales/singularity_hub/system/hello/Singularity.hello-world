Bootstrap: docker
From: ubuntu:14.04

%labels
MAINTAINER vanessasaur
WHATAMI dinosaur

%environment
DINOSAUR=vanessasaurus
export DINOSAUR

%files
rawr.sh /rawr.sh

%post
chmod u+x /rawr.sh

%runscript
exec /bin/bash /rawr.sh
