BootStrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%files
    requirements.txt

%setup
    cp requirements.txt $SINGULARITY_ROOTFS/tmp/

%post
    apt-get install -y software-properties-common
    apt-add-repository ppa:longsleep/golang-backports
    apt-add-repository ppa:ubuntugis/ppa
    apt-add-repository universe
    apt-get update &&  apt-get install -y apt-transport-https python python-dev python-pip build-essential git openssl golang-go gdal-bin wget
    pip install --upgrade pip
    pip install --upgrade virtualenv setuptools
    pip install planet google-api-python-client pyCrypto earthengine-api

# Setup Go-Lang Paths
#    echo "export PATH=$PATH:/opt/go/bin" >> ~/.bashrc
#    echo "export GOPATH=/opt/go" >> ~/.bashrc
    export GOPATH=/opt/go

# Install Drive
    go get -u github.com/odeke-em/drive/cmd/drive

# Planet Batch Slack
    git clone https://github.com/samapriya/Planet-Batch-Slack-Pipeline-CLI
    cd Planet-Batch-Slack-Pipeline-CLI
    pip install -r requirements.txt
    python setup.py install

# Planet Clip and Ship
    cd
    git clone https://github.com/samapriya/planet-cyverse
    cd planet-cyverse/Tools/Clip-Ship-CLI && pip install -r requirements.txt
    python setup.py install

# Planet Earth Engine CLI
    cd
    cd planet-cyverse/Tools/Planet-GEE-Pipeline-CLI && pip install -r requirements.txt
    python setup.py install

##Install Drive
    go get -u github.com/odeke-em/drive/cmd/drive

# Install iRODS iCommands
    wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list
    apt-get update && apt-get install -y irods-icommands

%environment
# Setup Go-Lang Paths
    PATH=$PATH:/opt/go/bin
    GOPATH=/opt/go
  
# create blank Planet Key for the User    
    touch ~/.config/planet/pkey.csv


%labels
    Maintainer Tyson L Swetnam & Sam Roy
    Version v0.7
