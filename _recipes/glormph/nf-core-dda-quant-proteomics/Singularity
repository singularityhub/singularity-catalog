From:nfcore/base
Bootstrap:docker

%labels
    DESCRIPTION Singularity image containing all requirements for the lehtiolab/ddamsproteomics pipeline
    VERSION 1.2

%environment
    PATH=/opt/conda/envs/ddamsproteomics-1.2/bin:$PATH
    export PATH

%files
    environment.yml /
    tools/openms/environment.yml /openms_env.yml

%post
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda env create -f /openms_env.yml
    /opt/conda/bin/conda clean -a
