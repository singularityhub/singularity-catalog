Bootstrap: docker
From :  continuumio/miniconda3
IncludeCmd : yes

%files
environment.yml

%post
apt-get update && apt-get install -y procps && apt-get clean -y
/opt/conda/bin/conda env create -n myEnv -f /environment.yml 
/opt/conda/bin/conda clean -a

%environment
export PATH=/opt/conda/bin:$PATH
. /opt/conda/etc/profile.d/conda.sh
conda activate myEnv

%runscript
echo "hello this is a template build."

%help
Tools for Snakemake template

%labels
Author Sylvain Schmitt
