Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%labels
  Maintainer OSC Gateways

%help
This will run RStudio Server which must be mounted with dependencies into the container

%apprun rserver
  if ! [[ "$USER_PATH" = "" ]]; then
    export PATH="$USER_PATH"
  fi

  exec rserver "${@}"

%runscript
  if ! [[ "$USER_PATH" = "" ]]; then
    export PATH="$USER_PATH"
  fi

  exec rserver "${@}"

%post
yum install -y which
