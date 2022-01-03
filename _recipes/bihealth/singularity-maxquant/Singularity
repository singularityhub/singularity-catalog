BootStrap: docker
From: rockylinux/rockylinux:8.5

%labels
  Maintainer Manuel Holtgrewe

%help
  This container runs MaxQuant in Rocky Linux 8

%apprun vncserver
  exec vncserver "${@}"

%apprun vncpasswd
  exec vncpasswd "${@}"

%apprun websockify
  exec /opt/websockify/run "${@}"

%apprun maxquant
  exec mono /opt/MaxQuant/bin/MaxQuantCmd.exe "${@}"

%environment
  export PATH=/opt/TurboVNC/bin:${PATH}

%post
  # Software versions
  export TURBOVNC_VERSION=2.2.7
  export WEBSOCKIFY_VERSION=0.10.0

  dnf install -y dnf-plugins-core epel-release
  dnf update -y
  dnf upgrade -y
  dnf groupinstall -y "xfce"
  dnf install -y \
    less \
    wget \
    vim \
    unzip \
    strace \
    perl \
    python39 \
    python39-numpy \
    langpacks-en \
    glibc-all-langpacks \
    nmap-ncat \
    lsof

  echo LANG=en_US.UTF-8 >/etc/locale.conf

  rpmkeys --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
  dnf config-manager --add-repo https://download.mono-project.com/repo/centos8-stable.repo
  dnf install -y mono-complete


  cd /tmp
  rm -f MaxQuant_2.0.3.0.zip
  wget http://hpc-files.cubi.bihealth.org:/misc/maxquant/MaxQuant_2.0.3.0.zip
  mkdir -p /opt
  cd /opt
  ls -lh /tmp/MaxQuant_2.0.3.0.zip
  md5sum /tmp/MaxQuant_2.0.3.0.zip
  unzip /tmp/MaxQuant_2.0.3.0.zip
  mv 'MaxQuant 2.0.3.0' MaxQuant

  dbus-uuidgen > /etc/machine-id

  # Install TurboVNC https://turbovnc.org/Downloads/YUM
  cd /tmp
  wget https://sourceforge.net/projects/turbovnc/files/2.2.7/turbovnc-2.2.7.x86_64.rpm/download \
      -O turbovnc-2.2.7.x86_64.rpm
  dnf install -y turbovnc-2.2.7.x86_64.rpm
  rm -f turbovnc-2.2.7.x86_64.rpm

  # Install websockify
  cd /tmp
  rm -f v${WEBSOCKIFY_VERSION}.tar.gz
  wget https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz
  tar xf v${WEBSOCKIFY_VERSION}.tar.gz
  alternatives --set python3 /usr/bin/python3.9
  alternatives --set python /usr/bin/python3.9
  cd websockify-${WEBSOCKIFY_VERSION}
  python setup.py install
  rm -rf /tmp/v${WEBSOCKIFY_VERSION}.tar.gz /tmp/websockify-${WEBSOCKIFY_VERSION}

  dnf clean all
