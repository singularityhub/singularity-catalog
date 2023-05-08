BootStrap: docker
From: centos:centos7

%labels
  Maintainer Matthew Flister

%help
  This container runs the MATE desktop in CentOS 7.

%apprun vncserver
  exec vncserver "${@}"

%apprun vncpasswd
  exec vncpasswd "${@}"

%apprun websockify
  exec /opt/websockify/run "${@}"

%apprun mate-session
  exec mate-session "${@}"

%environment
  export PATH=/opt/TurboVNC/bin:${PATH}

%post
  # add paths
  mkdir -p /scratch/global /scratch/local /rcc/stor1/refdata /rcc/stor1/depts /rcc/stor1/projects
  
  # Software versions
  export TURBOVNC_VERSION=2.2.1
  export WEBSOCKIFY_VERSION=0.8.0

  # Get dependencies
  yum update -y && yum upgrade -y
  yum install -y epel-release
  yum groupinstall -y "X Window System" 
  yum groupinstall -y "MATE Desktop"
  yum install -y \
    less \
    wget \
    vim 
  
  dbus-uuidgen > /etc/machine-id
  
  # Install TurboVNC https://sourceforge.net/projects/turbovnc/files/2.2.1/turbovnc-2.2.1.x86_64.rpm/download
  wget https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc-${TURBOVNC_VERSION}.x86_64.rpm -q
  yum install -y turbovnc-${TURBOVNC_VERSION}.x86_64.rpm
  rm -rf turbovnc-${TURBOVNC_VERSION}.x86_64.rpm

  # Install websockify
  yum install -y \
    python \
    numpy
  mkdir -p /opt/websockify
  wget https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz -q -O - | tar xzf - -C /opt/websockify --strip-components=1
  rm -rf v*.tar.gz
