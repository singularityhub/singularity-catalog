################# Header: Define the base system you want to use ################
# Reference of the kind of base you want to use (e.g., docker, debootstrap, shub).
Bootstrap: docker
# Select the docker image you want to use (Here we choose tensorflow)
From: texlive/texlive:latest-full-doc

# Environment variables that should be sourced at runtime.
%environment
    # use bash as default shell
    SHELL=/bin/bash
    PYTHON_VERSION=3.9
    PATH="/opt/local/bin:${PATH}"
    PYTHONPATH="/opt:${PATH}"
    export SHELL PYTHON_VERSION PATH PYTHONPATH

%files
    requirements.txt requirements.txt

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
            git \
            entr
    apt-get clean

    # Install apt packages
    apt update
    apt install -y curl software-properties-common build-essential rsync python3-launchpadlib
    add-apt-repository ppa:deadsnakes/ppa -y

    echo "Install Garamond font"

    # Download and install URW Garamond font
    wget https://mirrors.ctan.org/fonts/urw/garamond.zip
    unzip garamond.zip
    mkdir -p /usr/local/texlive/texmf-local/fonts/type1/urw/garamond
    mkdir -p /usr/local/texlive/texmf-local/fonts/afm/urw/garamond
    cp garamond/ugmr8a.pfb garamond/ugmm8a.pfb garamond/ugmri8a.pfb garamond/ugmmi8a.pfb /usr/local/texlive/texmf-local/fonts/type1/urw/garamond/
    cp garamond/ugmr8a.afm garamond/ugmm8a.afm garamond/ugmri8a.afm garamond/ugmmi8a.afm /usr/local/texlive/texmf-local/fonts/afm/urw/garamond/

    # Unzip TeX support files
    unzip garamond/ugm.zip -d /usr/local/texlive/texmf-local/

    # Update filename database and font maps
    mktexlsr
    updmap-sys --enable Map=ugm.map    

    # Set the Python version
    PYTHON_VERSION=3.11
    export PYTHON_VERSION

    echo "Install python${PYTHON_VERSION}.."
    apt install -y python${PYTHON_VERSION}-dev python${PYTHON_VERSION}-distutils python${PYTHON_VERSION}-venv
    python${PYTHON_VERSION} -m venv /opt/local
    update-alternatives --install /usr/bin/python python /opt/local/bin/python${PYTHON_VERSION} 1
    update-alternatives --install /usr/bin/python3 python3 /opt/local/bin/python${PYTHON_VERSION} 1

    echo "Installing pip.."
    curl -sS https://bootstrap.pypa.io/get-pip.py | /opt/local/bin/python3
    update-alternatives --install /usr/local/bin/pip pip /opt/local/bin/pip${PYTHON_VERSION} 1
    update-alternatives --install /usr/local/bin/pip3 pip3 /opt/local/bin/pip${PYTHON_VERSION} 1

    echo "Install basic requirements"
    pip3 install wheel
    pip3 install --upgrade pip

    echo "Installing python requirements"
    pip3 install -r requirements.txt

    echo "Install NLTK data"
    /opt/local/bin/python3.11 -m nltk.downloader -d /opt/local/share/nltk_data all