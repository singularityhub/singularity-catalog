From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER **alcalan** <**alcalan@iarc.who.int**>
    DESCRIPTION Container image containing all requirements for pipeline DPclust-nf
    VERSION 1.0

%files
    environment.yml /

%post
    /opt/conda/bin/conda env update -n root -f /environment.yml
    /opt/conda/bin/conda clean -a





