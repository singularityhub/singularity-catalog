Bootstrap:docker
From:ubuntu:latest

%post
  SQUEEZEMETADBPATH=/uufs/chpc.utah.edu/common/home/round-group1/reference_seq_dbs/SqueezeMeta

  mkdir /uufs
  mkdir /scratch
  apt-get update

  apt-get install -y --no-install-recommends \
  apt-utils \
  build-essential \
  git

  cd /root
  git clone https://github.com/jtamames/SqueezeMeta.git
  cd SqueezeMeta

  perl scripts/preparing_databases/configure_nodb.pl ${SQUEEZEMETADBPATH}

%environment
  export PATH=/root/SqueezeMeta/scripts/:/root/SqueezeMeta/utils/:$PATH
  export TESTVAR="hello world"
