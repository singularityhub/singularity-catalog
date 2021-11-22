Bootstrap: docker
From: centos:7
%post
yum install -y wget perl g++ make
wget https://github.com/alexdobin/STAR.git #je telecharge le dossier
cd /STAR-master/sources #je rentre dans le dossier 
#chmod 755 /STAR-master/sources
make
%environment
export PATH=/STAR-master/sources:$PATH
%runscript
exec STAR "$@"
