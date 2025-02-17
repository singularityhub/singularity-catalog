Bootstrap: docker
From: python:3.13-slim

%labels
    Maintainer YourName
    Version 1.0
    Description interXXX - A Shiny for Python app in a Singularity container

%environment
    # Environment variables
    export PATH=/opt/ampcombi_interface:$PATH

%files
    app /opt/ampcombi_interface/app
    requirements.txt /opt/ampcombi_interface/requirements.txt

%post
    # Update and install necessary system packages
    apt-get update && apt-get install -y --no-install-recommends \
        libjpeg-dev \
        libpng-dev \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

    # Install Python dependencies
    pip install --no-cache-dir -r /opt/ampcombi_interface/requirements.txt

%runscript
    # Define the command to run the app
    exec shiny run --reload --launch-browser /opt/ampcombi_interface/app/app.py
