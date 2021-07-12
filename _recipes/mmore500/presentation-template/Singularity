Bootstrap: docker
From: ubuntu:18.04

################################################################################
# Basic bootstrap definition to build Ubuntu container
#
# sudo singularity build presentation-template.simg Singularity
#
################################################################################

%labels
    Maintainer Matthew Andres Moreno
    Contributors @vsoch
    Version 1.1.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files
    entrypoint.sh /entrypoint.sh

%post

DEBIAN_FRONTEND=noninteractive

################################################################################
# Install additional packages
################################################################################
apt-get clean && apt-get update && apt-get install -y \
    locales \
    language-pack-fi  \
    language-pack-en && \
    export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

apt-get install -y dialog \
                   apt-utils \
                   texlive \
                   texlive-full \
                   curl \
                   git \
                   fontconfig \
                   unzip \
                   make

################################################################################
# Install Fonts
################################################################################

# install Sans Forgetica fonts

curl -L http://www.sansforgetica.rmit/Common/Zips/Sans%20Forgetica.zip > sansforgetica.zip && \
    unzip sansforgetica.zip

mkdir -p /usr/share/fonts/opentype/ForgeticaSans /code /data && \
    cp Sans\ Forgetica/*.otf /usr/share/fonts/opentype/ForgeticaSans

# install Fira Type fonts

git clone https://github.com/mozilla/Fira && \
    mkdir -p /usr/share/fonts/truetype/FiraSans /usr/share/fonts/opentype/FiraSans && \
    cp Fira/ttf/*.ttf /usr/share/fonts/truetype/FiraSans/ && \
    cp Fira/otf/*.otf /usr/share/fonts/opentype/FiraSans/ && \
    fc-cache -f -v && \
    chmod -R 0777 /usr/share/fonts/* && \
    chmod u+x /entrypoint.sh

%runscript
    exec /bin/bash /entrypoint.sh "${@}"
