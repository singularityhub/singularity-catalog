BootStrap: docker
From:perl:latest

%runscript 
    cd /opt/bin
    exec "$@"

%post 
    export LANGUAGE="en_US"
    export LC_ALL="(unset)"
    export LANG="en_US.UTF-8" 
    apt-get update
    apt-get install -y git
    apt-get install -y make
    git clone https://github.com/jimhester/fasta_utilities
    mkdir -p /opt
    mkdir -p /data
    cd fasta_utilities
    perl Makefile.PL PREFIX=/opt
    make
    make install
