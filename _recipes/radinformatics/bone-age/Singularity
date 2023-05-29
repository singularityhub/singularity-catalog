Bootstrap: docker
From: vanessa/boneage

%runscript

    cd /code/boneage
    exec /usr/bin/python /code/boneage/cli.py "$@"


%post

    chmod -R 777 /data
    echo "To run, ./boneage.img --help"
