From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER Aron Skaftason <aron.skaftason@ki.se>
    DESCRIPTION Singularity image containing all requirements for the rnaseq_vax pipeline
    VERSION 0.20

%environment
    PATH=/opt/conda/envs/rnaseq-vax/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a