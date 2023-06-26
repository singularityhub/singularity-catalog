From:nfcore/base
Bootstrap:docker

%labels
    MAINTAINER **username** <**usermail**>
    DESCRIPTION Container image containing all requirements for **name of the pipeline**
    VERSION 1.0

%files
    environment.yml /

%post
    /opt/conda/bin/conda env update -n root -f /environment.yml
    /opt/conda/bin/conda clean -a






# environment.yml commit ID: c92804b

