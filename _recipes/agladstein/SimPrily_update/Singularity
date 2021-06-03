##############################
# http://singularity.lbl.gov/docs-recipes
##############################


##############################
# Header
##############################
BootStrap: docker
From: python:2.7

##############################
# Sections
##############################

%setup

    mkdir /app

    # Copy the current directory contents into the container at /app
    cp -r * /app

    # Install any needed packages specified in requirements.txt
    pip install -r requirements.txt

    # Create directory for OSG
    mkdir -p /cvmfs

    # Make executable
    chmod +x /app/simprily.py

