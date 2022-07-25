Bootstrap:docker  
From:ubuntu:16.04

%labels
MAINTAINER juanca09
SPECIES Dinosaur

%environment
RAWR_BASE=/code
export RAWR_BASE

%runscript
echo "This gets run when you run the image!" 
exec /bin/bash /code/dino.sh "$@"  

%post 
echo "This section happens once after bootstrap to build the image."  
mkdir -p /code  
echo "echo \"RoooAAAAR\"" >> /code/dino.sh
chmod u+x /code/dino.sh  

