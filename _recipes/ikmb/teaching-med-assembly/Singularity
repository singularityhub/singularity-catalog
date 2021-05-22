Bootstrap:docker
From:continuumio/miniconda2

%labels
    MAINTAINER Marc Hoeppner <m.hoeppner@ikmb.uni-kiel.de>
    DESCRIPTION Singularity image containing all requirements for the assembly exercise in the MSc course
    VERSION 2020

%environment
    PATH=/opt/conda/envs/teaching-assembly-2020/bin:/opt/bin:$PATH
    export PATH

%files
    environment.yml /
    FastaStat.pl /

%post

    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a

    mkdir -p /opt/bin
    mv /FastaStat.pl /opt/bin
    chmod +x /opt/bin/FastaStat.pl
