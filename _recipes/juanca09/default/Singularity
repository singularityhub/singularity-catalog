BootStrap: library
From: alpine:latest

%runscript
        #!/bin/sh
        if [ $# -eq 0 ]
        then
                i=0
        else
                i=$1
        fi
        while [ $i -ge 0 ]
        do
                sl
                i=$(($i-1))
        done

%post
    echo "Hello from inside the container"
    apk update
    apk add vim sl

%environment
    export PATH=$PATH:/usr/games
    export LC_ALL=C

