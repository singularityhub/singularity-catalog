Bootstrap:docker
From: ubuntu:18.04

%post
apt-get update && \
apt-get install -y build-essential git curl wget &&\
apt-get install -y tzdata &&\
apt-get install -y texlive-base texlive-luatex latexmk xzdec pandoc &&\
apt-get clean
update-locale LANG=nl_EN.UTF8
dpkg-reconfigure tzdata

%runscript
pandoc "$@"
