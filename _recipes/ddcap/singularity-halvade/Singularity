BootStrap: library
From: ubuntu:20.04

%labels
MAINTAINER ddecap
NAME Halvade

%environment
  PATH=/usr/local/halvade:/usr/local/spark/bin:/usr/local/spark/sbin:$PATH

  # Port option should match what we set Dropbear to listen on
  SPARK_SSH_OPTS="-p 2222 -o StrictHostKeyChecking=no"
  source bashrc

  export PATH SPARK_SSH_OPTS

%runscript
  /usr/local/halvade/halvade "$@"

%startscript
  /etc/init.d/dropbear start

%post
  echo "deb http://us.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
  cat /etc/apt/sources.list
  apt-get update && apt-get install -y curl wget gzip \
    rsync openjdk-8-jre python2.7 \
  # Install OpenSSH to communicate between containers, and openssh server
  apt-get install -y --no-install-recommends openssh-client dropbear \
    gcc make libcurl4-openssl-dev libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev unzip

  ln -s /usr/bin/python2.7 /usr/bin/python

  cd /usr/local

  VERSION=3.1.1
  wget https://archive.apache.org/dist/spark/spark-${VERSION}/spark-${VERSION}-bin-hadoop2.7.tgz
  gzip -d spark-${VERSION}-bin-hadoop2.7.tgz
  tar xf spark-${VERSION}-bin-hadoop2.7.tar

  mv spark-${VERSION}-bin-hadoop2.7 spark
  rm -f spark-${VERSION}-bin-hadoop2.7.tar

  # Set Dropbear port to 2222 (or whatever port was selected above)
   sed -i -e 's@\(DROPBEAR_PORT=\).*@\12222@' /etc/default/dropbear

  # install halvade
  mkdir halvade
  cd halvade
  HALV_VERSION=2.0.2
  wget https://bitbucket.org/dries_decap/halvadeforspark/downloads/halvade-${HALV_VERSION} -O halvade
  chmod a+x halvade
  wget https://bitbucket.org/dries_decap/halvadeforspark/downloads/halvade-assembly-${HALV_VERSION}.jar
  wget https://repo1.maven.org/maven2/org/seqdoop/hadoop-bam/7.10.0/hadoop-bam-7.10.0.jar
  wget https://repo1.maven.org/maven2/com/github/samtools/htsjdk/2.11.0/htsjdk-2.11.0.jar

  # install samtools, bwa and gatk
  cd /tmp/
  #samtools
  SAMTOOLS_V=1.10
  wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_V}/samtools-${SAMTOOLS_V}.tar.bz2
  tar -vxjf samtools-${SAMTOOLS_V}.tar.bz2
  cd samtools-${SAMTOOLS_V}
  make
  cp samtools /usr/local/halvade/
  cd ../
  rm samtools-${SAMTOOLS_V}.tar.bz2
  rm -r samtools-${SAMTOOLS_V}

  # bwa
  BWA_V=0.7.16a
  wget https://github.com/lh3/bwa/releases/download/v0.7.16/bwa-${BWA_V}.tar.bz2
  tar -vxjf bwa-${BWA_V}.tar.bz2
  cd bwa-${BWA_V}
  make
  cp bwa /usr/local/halvade/
  cd ../
  rm bwa-${BWA_V}.tar.bz2
  rm -r bwa-${BWA_V}

  # add gatk
  GATK_V=4.1.2.0
  wget https://github.com/broadinstitute/gatk/releases/download/${GATK_V}/gatk-${GATK_V}.zip
  unzip -j gatk-${GATK_V}.zip gatk-${GATK_V}/gatk-package-${GATK_V}-local.jar -d "/usr/local/halvade/"
  rm gatk-${GATK_V}.zip
