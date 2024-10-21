Bootstrap: docker
From: continuumio/miniconda3

# sudo singularity build hello-world Singularity

%runscript
    exec /opt/conda/bin/scif "$@"

%labels
    MAINTAINER vsochat@stanford.edu

%files
    hello-world.scif

%post
    apt-get update && apt-get install -y git build-essential
    /opt/conda/bin/pip install dateutils

    # Install SCIF
    cd /opt && git clone https://www.github.com/vsoch/scif.git
    cd scif
    /opt/conda/bin/pip install setuptools
    /opt/conda/bin/pip install -e .
    /opt/conda/bin/scif install /hello-world.scif
