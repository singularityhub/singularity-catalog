Bootstrap: docker
from: continuumio/miniconda3

%labels

MAINTAINER ynanyam@iastate.edu

%post

apt-get update -y

apt install -y wget git

export PATH=/opt/conda/bin:$PATH

echo 'export PATH=/usr/local/bin:/opt/conda/bin:$PATH' >>$SINGULARITY_ENVIRONMENT

#conda create --name bigscape

#source activate bigscape 

conda install -y numpy scipy scikit-learn

conda install -c bioconda hmmer biopython fasttree anaconda networkx

cd /usr/src

git clone https://git.wur.nl/medema-group/BiG-SCAPE.git

wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam31.0/Pfam-A.hmm.gz

gunzip Pfam-A.hmm.gz && hmmpress Pfam-A.hmm && mv Pfam-A.* /usr/src/BiG-SCAPE/.

chmod +x /usr/src/BiG-SCAPE/*.py

echo 'export PATH=/usr/src/BiG-SCAPE:$PATH' >>$SINGULARITY_ENVIRONMENT

mkdir -p /local/scratch

chmod 777 /local/scratch

mkdir -p /local/scratch/input /local/scratch/output
