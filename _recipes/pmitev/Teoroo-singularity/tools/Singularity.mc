Bootstrap:  docker
From: alpine

%runscript
  /usr/bin/mc

%setup

%files

%environment

%labels

%post
  apk add --no-cache mc vim
