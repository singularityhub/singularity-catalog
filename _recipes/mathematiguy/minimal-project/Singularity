################# Header: Define the base system you want to use ################
# Reference of the kind of base you want to use (e.g., docker, debootstrap, shub).
Bootstrap: docker
# Select the docker image you want to use (Here we choose tensorflow)
From: ubuntu:20.04

# Environment variables that should be sourced at runtime.
%environment
        # use bash as default shell
        SHELL=/bin/bash
        export SHELL

# Add files at build time
%files
        requirements.txt
        pkg /code/pkg
        setup.py /code/setup.py

################# Section: Defining the system #################################
# Commands in the %post section are executed within the container.
%post

        echo "Setting environment variables"
        export DEBIAN_FRONTEND=noninteractive
        
        echo "Installing Tools with apt-get"
        apt-get update
        apt-get install -y curl \
                wget \
                unzip \
                software-properties-common \
                git
        apt-get clean

        echo "Install python3.9.."
        apt install -y python3.9-dev python3.9-distutils
        update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

        echo "Installing pip.."
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9
        update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 1
        update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.9 1

        echo "Installing requirements.."
        pip3 install --upgrade pip
        pip3 install -r requirements.txt

        echo "Install local package.."
        python -m pip install -e /code

        echo "Creating mount points.."
        mkdir /dataset
        mkdir /tmp_log
        mkdir /final_log
