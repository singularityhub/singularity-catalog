#
#   Containerised environment for running the MONC model
#   Based on metomi-vms installation
#   By Chris Dearden
#

BootStrap: docker
From: ubuntu:18.04

%runscript
    exec echo "MONC container based on Ubuntu 18.04"

%files
    install-mosrs-ubuntu.sh /tmp/install-mosrs-monc.sh
    install-base-ubuntu.sh /tmp/install-base-monc.sh
    install-monc-extras_ubuntu1804 /tmp/install-monc-extras
    usr/local /usr/
    opt/metomi-site /opt/
    etc/subversion /tmp/ 
    var/www /var/

%environment

%post
    #Set timezone for tzdata
    export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
    echo "tzdata tzdata/Areas select Europe" >> preseed.txt
    echo "tzdata tzdata/Zones/Europe select London" >> preseed.txt
    apt-get -y update && apt-get install -y apt-utils
    
    apt-get install -y build-essential
    apt-get -yq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

    #Set preseed options
    debconf-set-selections preseed.txt
    apt-get install -y tzdata wget

    # Set up correct locales
    apt-get install -y locales
    locale-gen en_GB.UTF-8

    . /tmp/install-base-monc.sh
    rm /tmp/install-base-monc.sh
    . /tmp/install-mosrs-monc.sh
    rm /tmp/install-mosrs-monc.sh
    . /tmp/install-monc-extras
    rm /tmp/install-monc-extras

