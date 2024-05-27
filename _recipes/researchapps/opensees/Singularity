Bootstrap: docker
From: sorcerer01/opensees

%runscript

    exec /bin/sh -c /code/bin/OpenSees "$@"

%post

    mkdir /code
    mv /home/ubuntu/* /code
