Bootstrap: docker
From: trlandet/fenics-dev:latest

%post
    cp /home/fenics/bin/fenics-* /usr/local/bin

%runscript
    echo "Welcome to the Singularity FEniCS dev-env container"
    exec /bin/bash -i "$@"
