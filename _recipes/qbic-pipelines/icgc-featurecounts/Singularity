From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER Alexander Peltzer <alexander.peltzer@qbic.uni-tuebingen.de>
    DESCRIPTION Singularity image containing all requirements for ICGC-FeatureCounts pipeline
    VERSION 1.0.0dev

%files
    environment.yml /

%post
    /opt/conda/bin/conda env update -n root -f /environment.yml
    /opt/conda/bin/conda clean -a
