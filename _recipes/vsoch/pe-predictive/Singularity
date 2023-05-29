Bootstrap: docker
From: vanessa/pefinder

%runscript

    cd /code/pefinder
    exec /opt/conda/bin/python /code/pefinder/cli.py "$@"


%post

    chmod -R 777 /data
    echo "To run, ./pefinder.img --help"