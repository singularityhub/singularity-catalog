BootStrap: docker
From: postgres:12

%environment
    export HOSTNAME=localhost
    if [ -f /postgresrc ]; then 
        . /postgresrc 
    fi

%startscript
    /usr/local/bin/docker-entrypoint.sh postgres -h $HOSTNAME

%runscript
    /usr/local/bin/docker-entrypoint.sh postgres -h $HOSTNAME

%labels
    Author jmb@iseclab.org
    MAINTAINER Josh Bundt
    Version v0.0.2

%help
    Postgres v12
