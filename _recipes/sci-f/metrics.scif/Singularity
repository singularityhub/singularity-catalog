BootStrap: docker
From: continuumio/miniconda3

#
# sudo singularity build metrics Singularity
#

%help

This is an example for a container that serves to make it easy to run
various metrics over an analysis of interest (the container's main runscript).
Each installed app can be thought of as a particular context to evoke the
container's main runscript.

    # List all apps
    ./metrics apps

    # Run a specific app
    ./metrics run <app>

    # Execute primary runscript
    ./metrics

    # Loop over all apps
    for app in $(./metrics apps); do
        ./metrics run $app
    done


%runscript
    exec /bin/bash /entrypoint.sh

%files
    metrics.scif
    entrypoint.sh
    
%post
    apt-get update

    /opt/conda/bin/pip install scif
    /opt/conda/bin/scif install /metrics.scif
    chmod u+x /entrypoint.sh

%environment
    DEBIAN_FRONTEND=noninteractive
    export DEBIAN_FRONTEND
