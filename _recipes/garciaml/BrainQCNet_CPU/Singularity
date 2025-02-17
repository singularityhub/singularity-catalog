Bootstrap: docker
From: python:3.9-slim 

%labels
    Author MelanieGarcia
    Version 1.0.1
    Description Singularity image for BrainQCNet - CPU version

%files
    . /app

%post
    # Set timezone during build
    export TZ=Europe
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    echo $TZ > /etc/timezone

    # Install tzdata package to ensure timezones are available
    apt-get update && apt-get install -y tzdata

    # Install dependencies
    apt-get update && apt-get install -y python3 \
       python3-venv \
       make \
       tk-dev \
       tcl-dev \
       libgl1-mesa-glx \
    && apt-get install -yq libgtk2.0-dev \
    && rm -rf /var/lib/apt/lists/*

    cd /app
    make all

%environment
    export HOME=/app
    export PATH=/app/venv/bin:$PATH
    cd /app

%runscript
    cd /app
    # Define the default run command for the container
    exec venv/bin/python3 run.py "$@"


