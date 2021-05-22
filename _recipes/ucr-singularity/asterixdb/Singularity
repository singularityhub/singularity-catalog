Bootstrap: docker
From: centos:centos7.5.1804

%help
Singularity container for the 0.9.4 snapshot of AsterixDB

This environment utilizes the config and log files within your home directory.
If you want to change the config of AsterixDB, use the files in /opt/asterix/asterixdb-files/conf.
Logs for the program are located in /opt/asterix/asterixdb-files/logs.
Data files for the database are located in /opt/asterix/asterixdb-files/data.

Files located in the asterix user home directory under /opt/asterix can be changed freely, however
any other files located within the singularity instance are immutable.

%post
    yum -y update

    # Installs the requirements for building AsterixDB
    yum -y install git
    yum -y install java-1.8.0-openjdk-devel
    yum -y install centos-release-scl
    yum -y install rh-maven35
    yum -y install iproute
    yum -y install net-tools

    # Clones the AsterixDB repository to /opt
    cd /opt
    git clone https://github.com/apache/asterixdb.git

    # Sets the environment variables for maven
    export PATH="/opt/rh/rh-maven35/root/usr/bin:${PATH:-/bin:/usr/bin}"
    export MANPATH="/opt/rh/rh-maven35/root/usr/share/man:${MANPATH}"
    export PYTHONPATH="/opt/rh/rh-maven35/root/usr/lib/python2.7/site-packages${PYTHONPATH:+:}${PYTHONPATH:-}"
    export JAVACONFDIRS="/opt/rh/rh-maven35/root/etc/java${JAVACONFDIRS:+:}${JAVACONFDIRS:-}"
    export XDG_CONFIG_DIRS="/opt/rh/rh-maven35/root/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}"
    export XDG_DATA_DIRS="/opt/rh/rh-maven35/root/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

    # Builds AsterixDB
    cd /opt/asterixdb
    mvn clean package -DskipTests

    # Chowns the /opt/asterixdb folder to user with uid and gid 8889
    chown -R 8889:8889 /opt/asterixdb

%environment
    umask 022
