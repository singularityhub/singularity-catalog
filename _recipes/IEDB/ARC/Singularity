Bootstrap: docker
From: ubuntu:18.04
 
%post
apt-get update && \
    apt-get install -y python3-dev python3-pip hmmer ncbi-blast+ git && \
    apt-get clean
pip3 install bio-arc
chmod -R go+w /usr/local/lib/python3.6/dist-packages/ARC/data/

%runscript
exec $@
