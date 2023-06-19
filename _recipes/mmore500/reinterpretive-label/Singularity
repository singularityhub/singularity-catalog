################################################################################
# Basic bootstrap definition to build Ubuntu container
################################################################################

Bootstrap: shub
From: singularityhub/ubuntu

%labels
Maintainer Matthew Andres Moreno
Version 0.0.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files
. /opt/reinterpretive-label

%post
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

apt-get install -y dialog
apt-get install -y apt-utils
apt-get install -y texlive
apt-get install -y texlive-latex-extra
apt-get install -y texlive-xetex
apt-get install -y curl
apt-get install -y fontconfig
apt-get install -y unzip

curl -L https://www.fontsquirrel.com/fonts/download/poppins > poppins.zip
unzip poppins.zip

mkdir /usr/share/fonts/opentype
mv *.otf /usr/share/fonts/opentype

fc-cache -f -v

chmod 777 -R /opt

################################################################################
# Run the user's login shell, or a user specified command
################################################################################
%runscript
xelatex instance
