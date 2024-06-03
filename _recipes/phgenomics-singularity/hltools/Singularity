# Singularity recipe for commonly used tools developed by Heng Li 
# Samtools is no longer under Heng Li, but it was originally developed by Heng Li
Bootstrap: docker
From: ubuntu:artful-20180227

%help
A container with tools by Heng Li.
These include:
  Samtools
  BCFTools
  MiniMap2
  BWA

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
Samtools 1.8
BCFTools 1.8
BWA 0.7.17
MiniMap 2.10
seqtk 1.2
  
%files

  test.sh /opt/test.sh

%post
  set -x
  # BUILDING VARIABLES

  HTSLIB_VERSION=1.8 # indexes versions for samtools and bcftools
  BWA_VERSION=0.7.17
  MINIMAP2_VERSION=2.10
  SEQTK_VERSION=1.2
  
  # INSTALLING SOME DEPENDENCIES
  apt-get install --yes sudo
  
  sudo apt-get --yes update
  sudo apt-get --yes install locales
  
  sudo locale-gen en_US.UTF-8
  sudo update-locale
  
  sudo apt-get --yes install build-essential autoconf automake wget git zlib1g-dev libbz2-dev libncurses5-dev curl unzip python-dev liblzma-dev libcurl4-openssl-dev software-properties-common apt-transport-https
  
  # DOWNLOADING

  wget -O "samtools.tar.gz" https://github.com/samtools/samtools/archive/${HTSLIB_VERSION}.tar.gz
  wget -O "htslib.tar.gz" https://github.com/samtools/htslib/archive/${HTSLIB_VERSION}.tar.gz
  wget -O "bcftools.tar.gz" https://github.com/samtools/bcftools/archive/${HTSLIB_VERSION}.tar.gz
  wget -O "minimap2.tar.bz2" https://github.com/lh3/minimap2/releases/download/v${MINIMAP2_VERSION}/minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2
  wget -O "bwa.tar.gz" https://github.com/lh3/bwa/archive/v${BWA_VERSION}.tar.gz
  wget -O "seqtk.tar.gz" https://github.com/lh3/seqtk/archive/v${SEQTK_VERSION}.tar.gz
  
  # UNPACKING
  
  tar xf htslib.tar.gz
  tar xf samtools.tar.gz
  tar xf bcftools.tar.gz
  tar jxf minimap2.tar.bz2
  tar xf bwa.tar.gz
  tar xf seqtk.tar.gz
  
  # SETTING THE SCENE
  
  mv htslib-${HTSLIB_VERSION} htslib
  
  # COMPILING AND INSTALLING
  
  ## SAMTOOLS
  
  cd samtools-${HTSLIB_VERSION}
  autoheader
  autoconf -Wno-syntax
  ./configure --prefix /usr/local
  make
  sudo make install
  cd ..
  
  ## BCFTOOLS
  
  cd bcftools-${HTSLIB_VERSION}
  make && sudo mv bcftools /usr/local/bin
  cd ..
  
  ## MINIMAP2
  
  cd minimap2-${MINIMAP2_VERSION}_x64-linux
  sudo mv minimap2 /usr/local/bin
  cd ..
  
  ## BWA
  
  cd bwa-${BWA_VERSION}
  make && sudo mv bwa /usr/local/bin
  cd ..
  
  cd seqtk-${SEQTK_VERSION}
  make && sudo mv seqtk /usr/local/bin
  cd ..
  
  # DO SOME CLEAN UP
  rm -fr htslib* samtools* bcf* bwa* minimap2* seqtk* *.tar.gz
  
  echo "Sorting some env variables..."
  sudo echo 'LANGUAGE="en_US:en"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LC_ALL="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LC_CTYPE="UTF-8"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LANG="en_US.UTF-8"' >>  $SINGULARITY_ENVIRONMENT
  
  # CHMOD OF TEST.SH
  sudo chmod 0555 /opt/test.sh

%runscript
  echo "Welcome to HengLiTools Container" >&2
  exec "$@"
  
%test

  cd /opt
  ./test.sh

  # echo "Testing..."

  # mkdir test && cd test
  
  # echo "Downloading a reference..."
  # curl -L "https://www.ebi.ac.uk/ena/data/view/CP016627.1&display=fasta&download=fasta&filename=entry.fasta" > ref.fa
  
  # echo "Downloading some fastq data..."
  # ACCESSION="SRR3980470"
  # URL=ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${ACCESSION:0:6}/00${ACCESSION:9:10}/${ACCESSION}/
  
  # mkdir -p ${ACCESSION}
  # wget -O ${ACCESSION}/${ACCESSION}_R1.fastq.gz "${URL}*1*"
  # wget -O ${ACCESSION}/${ACCESSION}_R2.fastq.gz "${URL}*2*"
  
  # echo "TESTING seqtk..."
  # seqtk sample -s100  ${ACCESSION}/${ACCESSION}_R1.fastq.gz 10000 > sub1.fq
  # seqtk sample -s100  ${ACCESSION}/${ACCESSION}_R2.fastq.gz 10000 > sub2.fq
  
  # [ -f "sub1.fa" ] && \
  #   echo "seqtk... PASS" || \
  #   echo "seqtk... FAIL" && exit 1

  
  # echo "TESTING BWA and SAMTOOLS"
  # bwa index ref.fa
  # bwa mem ref.fa *.fq | samtools view -b | samtools sort -o reads.bam -
  
  # [ -f "reads.bam" ] && \
  #   echo "bwa and samtools... PASS" || \
  #   echo "bwa or samtools... FAIL" && exit 1
  
  # echo "TESTING bcftools"
  # bcftools mpileup -Ou -f ref.fa reads.bam | \
  # bcftools call -Ou -mv | \
  # bcftools filter -s LowQual -e '%QUAL<20 || DP>100' > var.flt.vcf
  
  # [ -f "var.flt.vcf" ] && \
  #   echo "bcftools... PASS" || \
  #   echo "bcftools... FAIL" && exit 1
  
  # echo "TESTING minimap2"
  # minimap2 -x sr -a ref.fa *.fq | samtools view -b | samtools sort - > reads2.bam
  
  # [ -f "reads2.bam" ] && \
  #   echo "minimap2... PASS" || \
  #   echo "minimap2... FAIL" && exit 1
  
  # cd ..
  
  # rm -rf test
  
  # echo "All tests successful..."
  
