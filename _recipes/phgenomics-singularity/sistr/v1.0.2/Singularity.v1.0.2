Bootstrap: docker
From: continuumio/miniconda3:4.5.4

%help
A Singularity image for SISTR

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
SISTR VERSION 1.0.2

%environment
VERSION=1.0.2
export VERSION
PATH=/opt/conda/bin:$PATH
export PATH

%files
requirements.txt

%post
 # set versions of software to install
  VERSION=1.0.2

  export PATH=/opt/conda/bin:$PATH

  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda

  conda install --yes --file requirements.txt
 
  echo "Sorting some env variables..."
  echo "SISTR installed on $(date "+%Y-%m-%d")" > /etc/dbupdate
  chmod 555 /etc/dbupdate
  
  echo "Done"

%runscript
  echo "Welcome to SISTR $VERSION" >&2
  cat /etc/dbupdate >&2
  exec sistr "$@"

%test
  echo "Testing SISTR"
  export PATH=/opt/conda/bin:$PATH
  cd /tmp
  GENOME=ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/945/GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.fna.gz
  OUT=asm.fna.gz
  wget -O $OUT $GENOME
  gzip -d $OUT
  sistr asm.fna | grep "Typhimurium"
  rm asm.fna
  echo "Success"
