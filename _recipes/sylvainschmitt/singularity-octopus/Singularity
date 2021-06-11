Bootstrap: docker
From :  continuumio/miniconda3

%files
environment.yml

%post
/opt/conda/bin/conda env create -n octopus environment.yml

%environment
export PATH="/opt/conda/envs/octopus/bin/":$PATH

%runscript
echo "octopus container: mapping-based variant caller that implements several calling models within a unified haplotype-aware framework"

%help
Tools for Octopus

%labels
Author Sylvain Schmitt
