BootStrap: docker
From: centos:centos7

%labels
  Maintainer Manuel Holtgrewe

%help
  This container runs VirtualBox for CentOS 7.

%apprun vncserver
  exec vncserver "${@}"

%apprun vncpasswd
  exec vncpasswd "${@}"

%apprun websockify
  exec /opt/websockify/run "${@}"

%environment
  export PATH=/opt/TurboVNC/bin:${PATH}

%post
  # Software versions
  export TURBOVNC_VERSION=2.2.1
  export WEBSOCKIFY_VERSION=0.8.0

  # Get dependencies
  yum clean all
  yum update -y && yum upgrade -y
  yum install -y epel-release
  yum groupinstall -y "X Window System"
  yum groupinstall -y "Xfce"
  yum install -y \
    less \
    wget \
    vim \
    unzip


  # Install VirtualBox 
  yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
  yum install -y VirtualBox

  dbus-uuidgen > /etc/machine-id

  # Install TurboVNC https://sourceforge.net/projects/turbovnc/files/2.2.1/turbovnc-2.2.1.x86_64.rpm/download
  wget https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc-${TURBOVNC_VERSION}.x86_64.rpm -q
  yum install -y turbovnc-${TURBOVNC_VERSION}.x86_64.rpm
  rm -rf turbovnc-${TURBOVNC_VERSION}.x86_64.rpm

  # Install websockify
  mkdir -p /opt/websockify
  wget https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz -q -O - | tar xzf - -C /opt/websockify --strip-components=1
  rm -rf v*.tar.gz
