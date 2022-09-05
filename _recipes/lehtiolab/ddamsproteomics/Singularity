From:nfcore/base
Bootstrap:docker

%labels
    DESCRIPTION Singularity image containing all requirements for the lehtiolab/ddamsproteomics pipeline
    VERSION 2.10

%environment
    PATH=/opt/conda/envs/ddamsproteomics-2.10/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a
