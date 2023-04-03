Bootstrap: docker
From: ubuntu:16.04

# sudo singularity build cs106b-builder Singularity

%labels
    MAINTAINER vsochat@stanford.edu

%setup
    mkdir -p ${SINGULARITY_ROOTFS}/code
    for file in "build.sh" "entrypoint.sh" "run.sh"
       do
           cp "${file}" ${SINGULARITY_ROOTFS}/code
    done    

%post
    # Install build dependencies
    apt-get update && \
    apt-get install -y g++ qt5-default build-essential qtmultimedia5-dev && \
    mkdir -p /code/Project

    # Add entrypoints for building and running

    # Make all executable
    chmod -R +x /code
    cd /code

%runscript
    cd /code && \
    exec /bin/bash /code/entrypoint.sh "$@"

