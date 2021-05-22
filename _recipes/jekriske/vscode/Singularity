Bootstrap: debootstrap
OSVersion: bionic
MirrorURL:  http://us.archive.ubuntu.com/ubuntu/
Include: ca-certificates curl git

%post
  mkdir -p /run/user /run/dbus
  chmod 1777 /run/user /run/dbus
  echo "deb http://us.archive.ubuntu.com/ubuntu bionic universe" >> /etc/apt/sources.list
  echo "deb http://us.archive.ubuntu.com/ubuntu bionic-security main" >> /etc/apt/sources.list
  apt update && apt install -y apt-transport-https gnupg2
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
  apt update
  apt install -y overlay-scrollbar-gtk2 \
                 libatk-bridge2.0 \
                 libcanberra-gtk-module \
                 unity-gtk2-module \
                 gtk2-engines-murrine \
                 language-pack-en-base \
                 libgail-3-0 \
                 libatk-adaptor \
                 libgail-common \
                 libgl1-mesa-glx \
                 libxss1 \
                 libgtk2.0-0 \
                 libasound2 \
                 code
  apt upgrade -y
  apt clean
  rm -rf /var/lib/apt/lists/*

%runscript
  exec code "$@"
