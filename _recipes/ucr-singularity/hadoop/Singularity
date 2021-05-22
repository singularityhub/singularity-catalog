Bootstrap: docker
From: centos:7

# This recipe starts from the default CentOS 7 docker image.

# The %post section includes all of the installation and setup.
%post
 
# Update to ensure that the image starts at the latest version of packages. 
yum update -y

# Install some useful packages.
 yum install -y vim screen tmux wget elinks less net-tools bind-utils git \
   unzip man

# Install/enable the EPEL repository. Some necessary software comes from here.
yum install -y epel-release

# Install ant and maven, to be able to work with Java.
yum install -y ant maven

# MariaDB is the CentOS drop-in MySQL equivalent.
yum install -y mariadb-devel mariadb-server

# Firefox and xauth, for remote access to instances This requires specially
# configured SSHD running on a high port in the container.
yum install -y firefox xauth

# SSH server and client.  SSH is a Swiss army knife, very useful to have the
# client and the option to have the server in container instances.
yum install -y openssh-server openssh-clients

# Install Java and the ability to install Python packagages via Pip.
yum install -y java-1.8.0-openjdk python2-pip python-devel

# Access Java objects in a JVM, or callback objects from Java.
pip install py4j

# Supervisor, to have the option to run processes using supervisord.
yum install -y supervisor

# Bzip2, to be able to install Anaconda Python
yum install -y bzip2

# Packages from source.  The standard pattern is to download and compare the
# expected and actual checksums, and exit if they don't match, before 
# performing further operations. 

# If you intend to update versions of Spark, Hadoop, etc - make sure to 
# check version compatibily and test after the update has been done! 

# HADOOP
yum install -y java-1.8.0-openjdk python2-pip python-devel java-1.8.0-openjdk-devel
cd /usr/local/src
wget http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
shasum_actual=`sha512sum hadoop-2.7.7.tar.gz | awk '{ print $1 }'`
shasum_should_be=17c8917211dd4c25f78bf60130a390f9e273b0149737094e45f4ae5c917b1174b97eb90818c5df068e607835120126281bcc07514f38bd7fd3cb8e9d3db1bdde
[[ "${shasum_should_be}" == "${shasum_actual}" ]] || exit -1
tar xzf hadoop-2.7.7.tar.gz

# HIVE
cd /usr/local/src
wget https://archive.apache.org/dist/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz
shasum_actual=`sha1sum apache-hive-2.3.3-bin.tar.gz | awk '{ print $1 }'`
shasum_should_be=decb462664eec0fb968829e796d4cd719185eba5
[[ "${shasum_should_be}" == "${shasum_actual}" ]] || exit -1
tar xzf apache-hive-2.3.3-bin.tar.gz

# SPARK
cd /usr/local/src
wget https://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
shasum_actual=`sha512sum spark-2.3.1-bin-hadoop2.7.tgz | awk '{ print $1 }'`
shasum_should_be=dc3a97f3d99791d363e4f70a622b84d6e313bd852f6fdbc777d31eab44cbc112ceeaa20f7bf835492fb654f48ae57e9969f93d3b0e6ec92076d1c5e1b40b4696
[[ "${shasum_should_be}" == "${shasum_actual}" ]] || exit -1
tar xzf spark-2.3.1-bin-hadoop2.7.tgz

## CASSANDRA 
#cd /usr/local/src
#wget https://archive.apache.org/dist/cassandra/3.11.3/apache-cassandra-3.11.3-bin.tar.gz
#shasum_actual=`sha1sum apache-cassandra-3.11.3-bin.tar.gz | awk '{ print $1 }'`
#shasum_should_be=dbc6ddbd074d74da97eff66db9699b5ce28ec6f0
#[[ "${shasum_should_be}" == "${shasum_actual}" ]] || exit -1
#tar xzf apache-cassandra-3.11.3-bin.tar.gz
#sed -i 's/$CASSANDRA_HOME\/logs/\/$CASSANDRA_LOG_DIR/' /usr/local/src/apache-cassandra-3.11.3/bin/cassandra

# GRADLE
cd /usr/local/src
wget https://services.gradle.org/distributions/gradle-4.10.2-all.zip
shasum_actual=`sha256sum gradle-4.10.2-all.zip | awk '{ print $1 }'`
shasum_should_be=b7aedd369a26b177147bcb715f8b1fc4fe32b0a6ade0d7fd8ee5ed0c6f731f2c
[[ "${shasum_should_be}" == "${shasum_actual}" ]] || exit -1
unzip -d /usr/local/src/gradle-4.10.2 gradle-4.10.2-all.zip

# SBT
curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
yum install -y sbt

## A wrapper for cqlsh so that it always contacts the right IP in a container
## This only works on the nodes that have Cassandra - meaning not the first node
## in the cluster!
#cat > /usr/local/bin/cqlsh << \ENDOFFILE
##!/bin/bash
#ip=`ifconfig | head -2 | grep inet | awk '{print $2 }'`
#/usr/local/src/apache-cassandra-3.11.3/bin/cqlsh "$@" $ip
#ENDOFFILE
#chmod 0755 /usr/local/bin/cqlsh

# Clean up yum cache to save some space.
yum clean all

# Append environment script invocation to end of global bashrc
echo "source /etc/env.sh" >> /etc/bashrc

%environment

# This is the RUNTIME environment for the different servers. 

# Home for the various servers
export HADOOP_HOME=/usr/local/src/hadoop-2.7.7
#export CASSANDRA_HOME=/usr/local/src/apache-cassandra-3.11.3
export SPARK_HOME=/usr/local/src/spark-2.3.1-bin-hadoop2.7
export HIVE_HOME=/usr/local/src/apache-hive-2.3.3

#JAVA_HOME determined dynamically
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# PATH and LD_LIBRARY_PATH modifications
#export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${SPARK_HOME}/bin:${CASSANDRA_HOME}/bin:${HIVE_HOME}/bin:${HIVE_HOME}/hcatalog/bin:${HIVE_HOME}/hcatalog/sbin:/usr/local/src/gradle-4.10.2/gradle-4.10.2/bin
export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${SPARK_HOME}/bin:${HIVE_HOME}/bin:${HIVE_HOME}/hcatalog/bin:${HIVE_HOME}/hcatalog/sbin:/usr/local/src/gradle-4.10.2/gradle-4.10.2/bin
export LD_LIBRARY_PATH=${HADOOP_HOME}/lib/native:/lib64:/usr/lib64

# Hadoop's classpath. Best generated dynamically
export HADOOP_CLASSPATH=$(hadoop classpath)
#export HADOOP_CLASSPATH=${HADOOP_CLASSPATH}:${CASSANDRA_HOME}/lib

# All nodes that run Spark have the same configuration directory, but 
# different IP addresses.
export SPARK_CONF_DIR=~/spark/conf
export SPARK_LOCAL_IP=`ifconfig | grep 'inet 10.0.' | awk '{ print $2 }'`

# NOTE: As singularity has changed the way it handles instance names,
# Instance names no longer appear inside the container's process list.
# As such, we can no longer use this method of per-instance based environment
# variables.

# Node specific environment variables, for use by all programs on those nodes.

## Answers the question: "which node is this", inside a Singularity instance.
## The instances have a standard naming convention (outside this repo), so this
## works.
#TEMP=`ps x --no-headers | grep -o 'Singularity instance.*]' | head -1`
#
## For each node, the configuration directories of services, log directories,
## and PID directories are provided as environment variables.  Nodes running
## Cassandra also have Cassandra resource management related variables.
#
## NODE 1
#if [[ "$TEMP" == *"_1"* ]]; then
#
#    export HADOOP_CONF_DIR=~/hadoop/conf/namenode
#    export YARN_CONF_DIR=~/hadoop/conf/namenode
#    #export CASSANDRA_CONF=~/cassandra/conf/cassandra-main
#    export HIVE_CONF_DIR=~/hive/conf/hive-main
#    
#    export HADOOP_LOG_DIR=~/hadoop/logs/hadoop.d/namenode
#    export YARN_LOG_DIR=~/hadoop/logs/yarn.d/namenode
#    #export CASSANDRA_LOG_DIR=~/cassandra/logs/cassandra-main
#    export SPARK_LOG_DIR=~/spark/logs/namenode
#
#    export HADOOP_PID_DIR=~/hadoop/pids/namenode
#    export YARN_PID_DIR=~/hadoop/pids/namenode
#    export SPARK_PID_DIR=~/spark/pids/namenode
#
## NODE 2    
#elif [[ "$TEMP" == *"_2"* ]]; then
#
#    export HADOOP_CONF_DIR=~/hadoop/conf/datanode-1
#    export YARN_CONF_DIR=~/hadoop/conf/datanode-1
#    #export CASSANDRA_CONF=~/cassandra/conf/cassandra-node-1
#    export HIVE_CONF_DIR=~/hive/conf/hive-node-1
#    
#    export HADOOP_LOG_DIR=~/hadoop/logs/hadoop.d/datanode-1    
#    export YARN_LOG_DIR=~/hadoop/logs/yarn.d/datanode-1
#    #export CASSANDRA_LOG_DIR=~/cassandra/logs/cassandra-node-1
#    export SPARK_LOG_DIR=~/spark/logs/datanode-1
#
#    export HADOOP_PID_DIR=~/hadoop/pids/datanode-1
#    export YARN_PID_DIR=~/hadoop/pids/datanode-1
#    export SPARK_PID_DIR=~/spark/pids/datanode-1
#    
#    ## Cassandra heap usage
#    #export MAX_HEAP_SIZE=2G
#    #export HEAP_NEWSIZE=800M
#
## NODE 3
#elif [[ "$TEMP" == *"_3"* ]]; then
#
#    export HADOOP_CONF_DIR=~/hadoop/conf/datanode-2
#    export YARN_CONF_DIR=~/hadoop/conf/datanode-2
#    #export CASSANDRA_CONF=~/cassandra/conf/cassandra-node-2
#    export HIVE_CONF_DIR=~/hive/conf/hive-node-2
#        
#    export HADOOP_LOG_DIR=~/hadoop/logs/hadoop.d/datanode-2
#    export YARN_LOG_DIR=~/hadoop/logs/yarn.d/datanode-2
#    #export CASSANDRA_LOG_DIR=~/cassandra/logs/cassandra-node-2
#    export SPARK_LOG_DIR=~/spark/logs/datanode-2
#    
#    export HADOOP_PID_DIR=~/hadoop/pids/datanode-2
#    export YARN_PID_DIR=~/hadoop/pids/datanode-2
#    export SPARK_PID_DIR=~/spark/pids/datanode-2
#    
#    ## Cassandra heap usage
#    #export MAX_HEAP_SIZE=2G
#    #export HEAP_NEWSIZE=800M
#
## NODE 4
#else
#
#    export HADOOP_CONF_DIR=~/hadoop/conf/datanode-3
#    export YARN_CONF_DIR=~/hadoop/conf/datanode-3
#    #export CASSANDRA_CONF=~/cassandra/conf/cassandra-node-3
#    export HIVE_CONF_DIR=~/hive/conf/hive-node-3
#        
#    export HADOOP_LOG_DIR=~/hadoop/logs/hadoop.d/datanode-3
#    export YARN_LOG_DIR=~/hadoop/logs/yarn.d/datanode-3
#    #export CASSANDRA_LOG_DIR=~/cassandra/logs/cassandra-node-3
#    export SPARK_LOG_DIR=~/spark/logs/datanode-3
#
#    export HADOOP_PID_DIR=~/hadoop/pids/datanode-3
#    export YARN_PID_DIR=~/hadoop/pids/datanode-3
#    export SPARK_PID_DIR=~/spark/pids/datanode-3
#    
#    ## Cassandra heap usage
#    #export MAX_HEAP_SIZE=2G
#    #export HEAP_NEWSIZE=800M
#    
#fi


# Application for the Hadoop primary namenode - there's no secondary
# namenode in this configuration.

# Note that the app can have different options - format (in which case
# it formats the namenode - run with caution! - or to start or stop
# services on the node. It must be provided with at least one valid 
# option.

%apprun hadoop_namenode
if [ "$1" == "format" ]; then
    echo "Formatting the namenode with a default name..."
    ${HADOOP_HOME}/bin/hdfs namenode -format hadoop_cluster

elif [ "$1" == "start" ]; then
    echo "Starting the namenode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh start namenode

    echo "Starting the resourcemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh start resourcemanager

elif [ "$1" == "stop" ]; then
    echo "Stopping the namenode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh stop namenode

    echo "Stopping the resourcemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh stop resourcemanager
    
else
  echo "Incorrect argument for application."
  echo "Correct usage is: singularity run --app hadoop-namenode <singularity image> [ ARGUMENT ]"
  echo "Arguments: format, start, stop"
fi

%apphelp hadoop_namenode
This app runs a Hadoop primary namenode and resourcemanager.

# App for the first datanode. Note that the app must be provided with a valid 
# option such as to to start or stop services on the node.

%apprun hadoop_data_node_1
if [ "$1" == "start" ]; then
    echo "Starting the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh start datanode

    echo "Starting the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh start nodemanager
    
    #echo "Starting cassandra..."
    #cassandra 2>&1 > /dev/null
    
elif [ "$1" == "stop" ]; then
    echo "Stopping the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh stop datanode

    echo "Stopping the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh stop nodemanager
    
else
  echo "Incorrect argument for application."
  echo "Correct usage is: singularity run --app hadoop-namenode <singularity image> [ ARGUMENT ]"
  echo "Arguments: start, stop"
fi

%apphelp hadoop_data_node_1
This app runs a Hadoop data node and nodemanager.

#This app runs a Hadoop data node and nodemanager, and Cassandra.

# App for the second datanode. Note that the app must be provided with a valid 
# option to start or stop services on the node.

%apprun hadoop_data_node_2
if [ "$1" == "start" ]; then
    echo "Starting the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh start datanode

    echo "Starting the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh start nodemanager
    
    #echo "Starting cassandra..."
    #cassandra 2>&1 > /dev/null
    
elif [ "$1" == "stop" ]; then
    echo "Stopping the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh stop datanode

    echo "Stopping the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh stop nodemanager
    
else
  echo "Incorrect argument for application."
  echo "Correct usage is: singularity run --app hadoop-namenode <singularity image> [ ARGUMENT ]"
  echo "Arguments: start, stop"
fi

%apphelp hadoop_data_node_2
This app runs a Hadoop data node and nodemanager.

#This app runs a Hadoop data node and nodemanager, and Cassandra.

# App for the third datanode. Note that the app must be provided with a valid 
# option to start or stop services on the node.

%apprun hadoop_data_node_3
if [ "$1" == "start" ]; then
    echo "Starting the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh start datanode

    echo "Starting the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh start nodemanager
    
    #echo "Starting cassandra..."
    #cassandra 2>&1 > /dev/null
   
elif [ "$1" == "stop" ]; then
    echo "Stopping the datanode..."
    ${HADOOP_HOME}/sbin/hadoop-daemon.sh stop datanode

    echo "Stopping the nodemanager..."
    ${HADOOP_HOME}/sbin/yarn-daemon.sh stop nodemanager
    
else
  echo "Incorrect argument for application."
  echo "Correct usage is: singularity run --app hadoop-namenode <singularity image> [ ARGUMENT ]"
  echo "Arguments: start, stop"
fi

%apphelp hadoop_data_node_3
This app runs a Hadoop data node and nodemanager.

#This app runs a Hadoop data node and nodemanager, and Cassandrda.
