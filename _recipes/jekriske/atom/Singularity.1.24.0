Bootstrap: docker
From: debian:stretch-slim

%labels
  Maintainer Jeff Kriske

%runscript
  atom "$@"

%post
  apt update && apt upgrade -y
  apt install -y --no-install-recommends \
                 apt-transport-https \
                 ca-certificates \
                 curl \
                 gconf2 \
                 gconf-service \
                 git \
                 gnupg2 \
                 gvfs-bin \
                 libasound2 \
                 libcap2 \
                 libgconf-2-4 \
                 libgtk2.0-0 \
                 libnotify4 \
                 libnss3 \
                 libxkbfile1 \
                 libxss1 \
                 libxtst6 \
                 libgl1-mesa-glx \
                 libgl1-mesa-dri \
                 python \
                 xdg-utils
  curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
  sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  apt-get update
  apt-get install -y --no-install-recommends atom
  apt-get clean
  sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  rm -rf /var/lib/apt/lists/*
