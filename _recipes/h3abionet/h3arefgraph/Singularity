From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER RefGraph Team
    DESCRIPTION Singularity image containing all requirements for the h3abionet/h3arefgraph pipeline
    VERSION 1.0dev

%environment
    PATH=/opt/conda/envs/nf-core-h3arefgraph-1.0dev/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a
