Bootstrap:docker
From:ubuntu

%labels
	MAINTAINER Shane Sanders
	
%files
	# Files for Build Go Here

%post
	# DEBCONF Configuration
    export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
    echo "tzdata tzdata/Areas select US" >> /opt/preseed.txt
    echo "tzdata tzdata/Zones/US select Chicago" >> /opt/preseed.txt
    debconf-set-selections /opt/preseed.txt
    rm /opt/preseed.txt

    # Update System
	apt update && apt upgrade -y
    
    # Install RepeatMasker Dependencies
    apt install -y wget make locales build-essential bzip2 libncurses5-dev libbz2-dev liblzma-dev zlib1g-dev
    #LANG=C perl -e exit
    locale-gen en_US.UTF-8
    cd /opt
    wget https://github.com/alexdobin/STAR/archive/2.7.8a.tar.gz
    tar -xzf 2.7.8a.tar.gz
    cd STAR-2.7.8a/
    cd source/
    make STAR
    chmod +x STAR
    cp STAR /opt/STAR-2.7.8a/bin/
    cd /opt
    rm 2.7.8a.tar.gz

%runscript
    /opt/STAR-2.7.8a/bin/STAR
    echo "/opt/STAR-2.7.8a/bin/STAR"
    
