Bootstrap: docker
From: ubuntu:16.10

%files
    meow.sh /meow.sh

%post
    chmod u+x /meow.sh

%labels
    MAINTAINER deadlyelder

%runscript
    exec /bin/bash /meow.sh
