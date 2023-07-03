Bootstrap: docker
From: nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

%labels
  Author Callum Walley

%environment
  export SHELL=/bin/bash
  export LC_ALL=C
  export LANG="en_US.UTF-8"
  export LANGUAGE="en_US"
  
  
  # add CUDA paths
  export CPATH="/usr/local/cuda/include:$CPATH"
  export PATH="/usr/local/cuda/bin:$PATH"
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
  export CUDA_HOME="/usr/local/cuda"

%post
  VOLSUNG_VER=1.13.1
  
  apt-get update -y 
  apt-get upgrade -y
  apt-get install -yq \
      cmake \
      curl \
      desktop-file-utils \
      diffuse \
      git \
      htop \
      libbotan-2-dev \
      libegl1-mesa \
      libfontconfig1 \
      libgl1-mesa-dev \
      libgomp1 \
      libhdf5-dev \
      libpulse-mainloop-glib0 \
      libxi-dev \
      libxrender-dev \
      libxt-dev \
      make \
      meld \
      python3 \
      python3-dev \
      python3-pip \
      python3-tk \
      shared-mime-info \
      vim \
      wget \
      xdg-utils

  # Py packages.
  pip3 install vtk h5py numpy matplotlib xlrd pandas xlrd 


  # add to ciphers
  echo "Ciphers aes128-cbc,3des-cbc,chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com" >> /etc/ssh/ssh_config
  echo "Ciphers aes128-cbc,3des-cbc,chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com" >> /etc/ssh/sshd_config

  wget https://s3.amazonaws.com/volsung-install-files/volsung-LinuxMint-19.1-v$VOLSUNG_VER.tar.gz
  tar -xvf volsung-LinuxMint-19.1-v$VOLSUNG_VER.tar.gz
  cd volsung-LinuxMint-19.1-v$VOLSUNG_VER

  # create the main installation folder
  mkdir /opt/volsung

  # if the folder previously existed clean it of some old, superfluous files
  rm -rf /opt/volsung/libvtk*-8.2*
  rm -rf /opt/volsung/libQt*.so.5.11
  rm -rf /opt/volsung/libQt*.so.5.11.2

  # copy the new files over
  cp -ra * /opt/volsung

  # install the python scripts
  cd python
  tar -xvf volsung-0.0.0.tar.gz
  cd volsung-0.0.0
  ./setup.py install
  cd ..
  rm -rf volsung-0.0.0
  cd ..   

  # install the mime types
  ln -sf /opt/volsung/desktop/brynhild.xml /usr/share/mime/packages/brynhild.xml
  ln -sf /opt/volsung/desktop/swanhild.xml /usr/share/mime/packages/swanhild.xml
  ln -sf /opt/volsung/desktop/gudrun.xml /usr/share/mime/packages/gudrun.xml
  ln -sf /opt/volsung/desktop/sigrun.xml /usr/share/mime/packages/sigrun.xml

  # install the desktop shortcuts
  ln -sf /opt/volsung/desktop/*.* /usr/share/applications

  # update databases
  update-mime-database /usr/share/mime
  update-desktop-database /usr/share/desktop || true

  # update associations
  xdg-mime default volsung-brynhild.desktop application/x-brynhild
  xdg-mime default volsung-swanhild.desktop application/x-swanhild
  xdg-mime default volsung-gudrun.desktop application/x-gudrun
  xdg-mime default volsung-sigrun.desktop application/x-sigrun

  # update icons
  xdg-icon-resource install --context mimetypes --size 48 /opt/volsung/brynhild-icon48.png application-x-brynhild
  xdg-icon-resource install --context mimetypes --size 48 /opt/volsung/swanhild-icon48.png application-x-swanhild
  xdg-icon-resource install --context mimetypes --size 48 /opt/volsung/gudrun-icon48.png application-x-gudrun
  xdg-icon-resource install --context mimetypes --size 48 /opt/volsung/sigrun-icon48.png application-x-sigrun
  xdg-icon-resource install --context mimetypes --size 48 /opt/volsung/signy-icon48.png application-x-signy

  # install symbolic links to /usr/local/bin
  ln -sf /opt/volsung/brynhild /usr/local/bin/brynhild
  ln -sf /opt/volsung/swanhild /usr/local/bin/swanhild
  ln -sf /opt/volsung/gudrun /usr/local/bin/gudrun
  ln -sf /opt/volsung/sigrun /usr/local/bin/sigrun
  ln -sf /opt/volsung/sigurd /usr/local/bin/sigurd
  ln -sf /opt/volsung/signy /usr/local/bin/signy
  ln -sf /opt/volsung/odin /usr/local/bin/odin

  rm -rf volsung-LinuxMint-19.1-v$VOLSUNG_VER.tar.gz
  echo "Yay!"

  # echo "\n #Cuda paths \n" >> /environment
  # echo 'export CPATH="/usr/local/cuda/include:$CPATH"' >> /environment
  # echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> /environment
  # echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> /environment
  # echo 'export CUDA_HOME="/usr/local/cuda"' >> /environment
