From:continuumio/miniconda3:4.5.12
Bootstrap:docker

%labels
    MAINTAINER Max Emil Schön <max-emil.schon@icm.uu.se>
    DESCRIPTION Singularity image containing epa-ng, mafft, raxml-ng and gappa
    VERSION 0.0

%environment
    PATH=/opt/conda/envs/placement/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    apt-get update
    apt-get install -y procps libxtst6 unzip
    apt-get clean -y

    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a

    wget https://github.com/amkozlov/raxml-ng/releases/download/0.8.1/raxml-ng_v0.8.1_linux_x86_64.zip
    unzip raxml-ng_v0.8.1_linux_x86_64.zip
    mv raxml-ng /usr/local/bin


%test
/opt/conda/envs/placement/bin/mafft --version
/opt/conda/envs/placement/bin/python3 --version
/opt/conda/envs/placement/bin/epa-ng --version
/opt/conda/envs/placement/bin/gappa --help
/opt/conda/envs/placement/bin/trimal --version
