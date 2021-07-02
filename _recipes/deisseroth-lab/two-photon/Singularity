# Singularity recipe file for d-lab bruker-rip container.

bootstrap: docker-daemon
from: scr.svc.stanford.edu/deisseroth-lab/bruker-rip:latest

%help
  First build the docker container:
    docker build -t scr.svc.stanford.edu/deisseroth-lab/bruker-rip:latest .
  Then build this file (assumes root as build directory):
    sudo singularity build bruker-rip.sif Singularity
  And run the rip script!
    singularity run --bind=/path/to/top-level:/data bruker-rip.sif

%runscript
  /bin/bash /apps/runscript.sh
