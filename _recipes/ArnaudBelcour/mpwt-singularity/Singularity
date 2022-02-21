Bootstrap: docker
From: ubuntu:18.04

%files
   pathway-tools-24.0-linux-64-tier1-install /opt

%environment
    export PATH="$PATH:/programs/pathway-tools:"
    export PYTHONIOENCODING=utf8

%post
     apt-get -y update && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y \
     curl \
     csh \
     git \
     ncbi-blast+ \
     libxm4 \
     python3.6-dev \
     python3.6-distutils \
     iputils-ping \
     gnome-terminal;\
     apt-get clean; \
     apt-get purge; \
     mkdir programs;\
     mkdir -p /home/your/external/folder/ptools;\
     chmod u+x /opt/pathway-tools-24.0-linux-64-tier1-install;\
     ./opt/pathway-tools-24.0-linux-64-tier1-install --InstallDir /programs/pathway-tools --PTOOLS_LOCAL_PATH /home/your/external/folder/ptools --InstallDesktopShortcuts 0 --mode unattended;\
     mkdir -p /opt/ptools;\
     cp -r /home/your/external/folder/ptools/ptools-local /opt/ptools;\
     rm /opt/pathway-tools-24.0-linux-64-tier1-install;\
     curl https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3;\
     pip3 install mpwt
