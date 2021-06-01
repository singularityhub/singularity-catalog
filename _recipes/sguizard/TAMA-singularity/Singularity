Bootstrap: docker
From: ubuntu:18.04
Stage: build

%environment
    export LC_ALL=C
    export APPS_HOME=/apps
    export APP_NAME=${APPS_HOME}/tama
    export APP_GIT=https://github.com/GenomeRIK/tama
    export APP_COMMIT=d39bc7fedffda5b54aeae7337fe92f17ae5c1b03


%post
    BUILD_DATE=`date`
    export APPS_HOME=/apps
    export APP_NAME=${APPS_HOME}/tama
    export APP_GIT=https://github.com/GenomeRIK/tama
    export APP_COMMIT=d39bc7fedffda5b54aeae7337fe92f17ae5c1b03

    export DEBIAN_FRONTEND=noninteractive
    export DEBCONF_NONINTERACTIVE_SEEN=true
    echo "export BUILD_DATE=\"${BUILD_DATE}\"" >> $SINGULARITY_ENVIRONMENT

    apt update
    apt install -y perl-modules

    echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt
    echo "tzdata tzdata/Zones/Europe select Paris" >> /tmp/preseed.txt
    debconf-set-selections /tmp/preseed.txt
    #rm /etc/timezone
    #rm /etc/localtime
    apt-get install -y tzdata

    apt-get install -y software-properties-common
    apt-add-repository universe
    apt install -y dialog
    apt install -y python2.7-minimal python-pip git dos2unix ncbi-blast+ bedtools samtools
    pip install biopython==1.76
    pip install pysam

    mkdir $APPS_HOME
    cd $APPS_HOME
    git clone $APP_GIT
    cd $APP_NAME
    git checkout $APP_COMMIT
    DOS_FILES=`find $APP_NAME -type f|grep -v '\.git'|grep -v 'images'`
    for i in $DOS_FILES
    do
        dos2unix $i
    done

    cd /usr/local/bin
    ln -s $APP_NAME/tama_collapse.py
    ln -s $APP_NAME/tama_merge.py
	for i in $(find /apps/tama/tama_go/ -type f -executable)
	do
		sed -i '1s|^|#!/usr/bin/env python\n\n|' $i
		ln -s $i
	done


    apt purge -y git dos2unix
    apt autoremove -y
    apt clean

%test
    #!/bin/bash

    tama_collapse.py -h > /dev/null 2>&1
    EXIT_CODE_TAMA_COLLAPSE=$?

    tama_merge.py -h > /dev/null 2>&1
    EXIT_CODE_TAMA_MERGE=$?

    if [ $EXIT_CODE_TAMA_COLLAPSE -eq 0 ]; then
        echo "TEST: RUNNING TAMA COLLAPSE HELP: OK"
    else
        echo "TEST: RUNNING TAMA COLLAPSE HELP: NOT OK"
    fi


    if [ $EXIT_CODE_TAMA_MERGE -eq 0 ]; then
        echo "TEST: RUNNING TAMA MERGE HELP: OK"
    else
        echo "TEST: RUNNING TAMA MERGE HELP: NOT OK"
    fi


    if [ $EXIT_CODE_TAMA_COLLAPSE -eq 0 ]  && [ $EXIT_CODE_TAMA_MERGE -eq 0 ]; then
        echo "TEST: OK"
    elif [ $EXIT_CODE_TAMA_COLLAPSE -ne 0 ] && [ $EXIT_CODE_TAMA_MERGE -eq 0 ]; then
        echo "TEST: NOT OK: Cannot execute tama_collapse.py"
        exit 1
    elif [ $EXIT_CODE_TAMA_COLLAPSE -eq 0 ] && [ $EXIT_CODE_TAMA_MERGE -ne 0 ]; then
        echo "TEST: NOT OK: Cannot execute tama_merge.py"
        exit 1
    elif [ $EXIT_CODE_TAMA_COLLAPSE -ne 0 ] && [ $EXIT_CODE_TAMA_MERGE -ne 0 ]; then
        echo "TEST: NOT OK: Cannot execute tama_collapse.py" and tama_merge.py"
        exit 1
    else
        echo "I Shouldn t be here ......
        exit 1
    fi


#%runscript
#    echo "Container was created $BUILD_DATE"
#    echo "Arguments received: $*"
#    exec echo "$@"

%labels
    Author Sebastien Guizard (Based on https://github.com/joelnitta/sqanti3-docker/commits/main)
    OS Ubuntu
    PROG TAMA
    Version commit d39bc7fedffda5b54aeae7337fe92f17ae5c1b03

%help
    This container has been built from the Ubuntu 18.04.
    TAMA commit d39bc7fedffda5b54aeae7337fe92f17ae5c1b03 has been installed from github repo (https://github.com/GenomeRIK/tama).

    TAMA is composed of two python scripts:
        - tama_collapse.py (https://github.com/GenomeRIK/tama/wiki/Tama-Collapse)
        - tama-merge.py (https://github.com/GenomeRIK/tama/wiki/Tama-Merge)

    USAGE:
    singularity exec TAMA.sif tama_collapse.py -h
