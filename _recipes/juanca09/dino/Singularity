Bootstrap:docker  
From:centos:7

%labels
MAINTAINER juanca09
SPECIES Dinosaur

%environment
RAWR_BASE=/code
export RAWR_BASE

%runscript
echo "This gets run when you run the dino image!" 
exec /bin/bash /code/dino.sh "$@"  

%post 
echo "This section happens once after bootstrap to build the image."  
mkdir -p /code
yum install epel-release -y
yum install figlet -y
echo "echo \"RooAAARRRR !!!\"|figlet" >> /code/dino.sh
chmod u+x /code/dino.sh  

