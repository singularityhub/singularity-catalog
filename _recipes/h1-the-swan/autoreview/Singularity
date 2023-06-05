Bootstrap: docker
From: ubuntu:18.04

# Based on https://github.com/mcw-rcc/apache-spark

%files
  requirements.txt
  .

%environment
  export SPARK_HOME=/opt/spark
  export PATH=${SPARK_HOME}/bin:${PATH}
  export PYSPARK_PYTHON=python3
  export PYSPARK_DRIVER_PYTHON=python3

%post
  export SPARK_VERSION=2.4.4
  export HADOOP_VERSION=2.7


  apt-get update
  apt-get install -y --no-install-recommends \
    openjdk-8-jre \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    wget

  # # install python packages
  # pip install --no-binary --upgrade \
  #   wheel \
  #   numpy \
  #   scipy \
  #   jupyter \
  #   pandas \
  #   pyspark

  # pip3 install --no-binary --upgrade \
  #   wheel \
  #   numpy \
  #   scipy \
  #   jupyter \
  #   jupyterhub \
  #   pandas \
  #   pyspark
  #
  #install spark
  mkdir -p /opt/spark
  wget http://mirrors.sonic.net/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
  tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt/spark --strip-components=1

  rm -rf /var/lib/apt/lists/*

  pip3 install -r requirements.txt

  python3 setup.py install
