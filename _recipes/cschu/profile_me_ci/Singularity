Bootstrap: docker
From: ubuntu:20.04
IncludeCmd: yes

%labels
  MAINTAINER cschu (cschu1981@gmail.com)
  VERSION v.0.2

%environment
export LC_ALL=C
#export PATH=/opt/software/eggnog-mapper:/opt/software/eggnog-mapper/bin:/opt/software/classify-genomes:$PATH:/opt/software/miniconda3/bin
export PATH=/opt/software/miniconda3/bin:/opt/software/eggnog-mapper:/opt/software/classify-genomes:$PATH
alias python="python3"

%post
  apt-get update
  apt-get install -y apt-transport-https apt-utils software-properties-common
  apt-get install -y add-apt-key
  export DEBIAN_FRONTEND=noninteractive
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
  apt-get install -y tzdata
  dpkg-reconfigure --frontend noninteractive tzdata

  apt-get install -y wget python3-pip git

  mkdir -p /opt/software

  wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
  bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/software/miniconda3
  rm -f Miniconda3-latest-Linux-x86_64.sh


  /opt/software/miniconda3/bin/conda install -y -c conda-forge -c bioconda \
    'diamond=2.0.11=hdcc8f71_0' \
    'prodigal=2.6.3=h779adbc_3' \
    'hmmer=3.3.2=h1b792b2_1' \
    'cd-hit=4.8.1=h2e03b76_5' \
    'pip<=20.2.1' \
    'vsearch=2.17.1=h95f258a_0' \
    samtools \
    'cdbtools=0.99=h9a82719_6' \
    'bwa=0.7.17=h5bf99c6_8'
  # /opt/software/miniconda3/bin/conda install -y -c conda-forge -c bioconda diamond prodigal hmmer cd-hit vsearch samtools cdbtools bwa
  # - perl

  # install eggnog-mapper
  cd /opt/software
  git clone https://github.com/eggnogdb/eggnog-mapper.git
  cd eggnog-mapper
  git checkout 5415cc83b66450030f6d19915eec6bb4007e13ab
  git log -1
  # /opt/software/miniconda3/bin/conda install --file requirements.txt
  /opt/software/miniconda3/bin/pip install -r requirements.txt
  # pip3 install -r requirements.txt

  # install macsyfinder
  cd /opt/software
  git clone https://github.com/gem-pasteur/macsyfinder.git
  cd macsyfinder
  git checkout 419224e859cb4cd710bc0fdfa251d817ba53b3b6
  /opt/software/miniconda3/bin/pip install .
  # pip3 install .

  # install classify-genomes
  # export PATH=/opt/software/miniconda3/bin
  cd /opt/software
  # git clone https://github.com/AlessioMilanese/classify-genomes.git
  git clone https://github.com/cschu/classify-genomes.git
  cd classify-genomes
  git checkout refactor/allow_containerisation
  
  
  # python3 setup.py
  wget https://zenodo.org/record/3364101/files/db_mOTU_v2.5.0.tar.gz
  echo "f533a7b55fc133589f08f50648548b42  db_mOTU_v2.5.0.tar.gz" > md5sums.txt
  md5sum -c md5sums.txt
  
  tar xvzf db_mOTU_v2.5.0.tar.gz
  rm -rf db_mOTU/db_mOTU_bam_header_CEN
  rm -rf db_mOTU/db_mOTU_bam_header_NR
  rm -rf db_mOTU/db_mOTU_taxonomy_CAMI.tsv
  rm -rf db_mOTU/db_mOTU_MAP_MGCs_to_mOTUs_in-line.tsv
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.amb
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.ann
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.annotations
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.bwt
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.pac
  rm -rf db_mOTU/db_mOTU_DB_CEN.fasta.sa
  rm -rf db_mOTU/db_mOTU_genes_length_NR
  rm -rf db_mOTU/db_mOTU_DB_NR.fasta.amb
  rm -rf db_mOTU/db_mOTU_DB_NR.fasta.ann
  rm -rf db_mOTU/db_mOTU_DB_NR.fasta.bwt
  rm -rf db_mOTU/db_mOTU_DB_NR.fasta.pac
  rm -rf db_mOTU/db_mOTU_DB_NR.fasta.sa
  rm -rf db_mOTU/db_mOTU_padding_coordinates_NR.tsv
  rm -rf db_mOTU/db_mOTU_padding_coordinates_CEN.tsv
  rm -rf db_mOTU/db_mOTU_taxonomy_ref-mOTUs_short_names.tsv
  rm -rf db_mOTU/db_mOTU_test
  
  chmod -R 777 db_mOTU
  
  ## blargh
  # trigger rebuild
