From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER Timo Lucas <timo-niklas.lucas@student.uni-tuebingen.de>
    DESCRIPTION Singularity image containing all requirements for microarray-qc-workflow pipeline
    VERSION 0.1.0

%files
    environment.yml /

%post
    /opt/conda/bin/conda env update -n root -f /environment.yml
    /opt/conda/bin/conda clean -a
