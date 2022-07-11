BootStrap: docker
From: ubuntu:18.04

%files

    gen-keypair.py /usr/local/bin
    merge.py /usr/local/bin
    collect.py /usr/local/bin

%environment
    export PATH=/usr/local/bin:$PATH
    export PYTHONPATH=/usr/lib/python3/dist-packages:$PYTHONPATH

%post

    apt-get update && apt-get -y install python python3 python3-pip wget curl openssh-client

    pip3 install cffi cryptography

    chmod -R go+rX /usr/lib/python3/dist-packages

    chmod a+x /usr/local/bin/merge.py

    chmod a+x /usr/local/bin/collect.py

    chmod a+x /usr/local/bin/gen-keypair.py

