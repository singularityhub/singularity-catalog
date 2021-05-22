From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER Tiffany Delhomme <delhommet@students.iarc.fr>
    DESCRIPTION Container image containing requirements for iarcbioinfo/vt-nf pipeline
    VERSION 1.0

%files
    environment.yml /

%post
    /opt/conda/bin/conda env update -n root -f /environment.yml
    /opt/conda/bin/conda clean -a
