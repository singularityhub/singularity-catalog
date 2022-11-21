bootstrap: docker
from: ubuntu:18.04

%environment
 export PATH=$PATH:/blender/blender
 export PATH=$PATH:/miniconda/bin
 export PATH=$PATH:/julia-1.4.1/bin

 export DEBIAN_FRONTEND=noninteractive

%runscript
  exec bash "$@"

%post
 apt-get update
 apt-get update

 # set noninteractive installation
 #install tzdata package
 apt-get install -y tzdata
 # set your timezone
 ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
 dpkg-reconfigure --frontend noninteractive tzdata

 apt-get install -y software-properties-common
 add-apt-repository ppa:openscad/releases
 apt-get update --fix-missing
 apt-get install -y openscad libgeos-dev libcairo2-dev libffi-dev python3-tk wget git
 apt-get install -y xvfb
 apt-get clean

 # Install Julia
 wget "https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz" \
      -O "/julia.tar.gz"
 tar xvzf "/julia.tar.gz"
 ln -s /julia-1.4.1/bin/julia /usr/bin/julia
 chmod +x /usr/bin/julia

 # Setup blender
 wget "https://yale.box.com/shared/static/8wsh0mbvvxfds04xwaef034dcocjrq5w.gz" \
      -O /blender.tar.gz
 tar xf /blender.tar.gz
 rm /blender.tar.gz
 mv blender-2.* /blender
 chmod +x blender/blender
    
 # blender egg addon
 #git clone "https://github.com/CNCLgithub/blender-egg-importer.git" /blender/2.82/scripts/addons/blender-egg-importer

 # Setup conda
 wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O conda.sh
 bash conda.sh -b -p /miniconda
 rm conda.sh


 # Add an sbatch workaround
 echo '#!/bin/bash\nssh -y "$HOSTNAME"  sbatch "$@"'  > /usr/bin/sbatch
 chmod +x /usr/bin/sbatch

 # Add an scancel workaround
 echo '#!/bin/bash\nssh -y "$HOSTNAME"  scancel "$@"'  > /usr/bin/scancel
 chmod +x /usr/bin/scancel

 # Add an srun workaround
 echo '#!/bin/bash\nssh -y "$HOSTNAME"  srun "$@"'  > /usr/bin/srun
 chmod +x /usr/bin/srun
