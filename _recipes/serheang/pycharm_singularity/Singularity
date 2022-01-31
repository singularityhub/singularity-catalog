bootstrap: docker
from:alpine:latest

%labels
  MAINTAINER setan
  WHATAMI pycharm-community
  VERSION 2019.2

%environment
  export PATH=/usr/local/bin:$PATH

%post
  export PYCHARM="pycharm-community-2019.2.3"
  apk update
  apk add wget 
  apk add python3 py3-pip 
  apk add openjdk11-jre
  apk add libcanberra-gtk3
  apk add xfce4 xfce4-terminal
  ## PREP
  rm -rf /opt/${PYCHARM}
  rm -f /opt/pycharm
  rm -f /usr/local/bin/pycharm
  rm -f /usr/local/bin/inspect

  ## Get PyCharm
  wget https://download.jetbrains.com/python/${PYCHARM}.tar.gz
  tar zxvf ${PYCHARM}.tar.gz -C /opt
  ln -s /opt/${PYCHARM} /opt/pycharm
  ln -s /opt/pycharm/bin/pycharm.sh /usr/local/bin/pycharm
  ln -s /opt/pycharm/bin/inspect.sh /usr/local/bin/inspect

  ## CLEANUP
  rm ${PYCHARM}.tar.gz

%runscript
  echo "Run Pycharm in alpine container"
  ## piping error to /dev/null to reduce clutter on screen
  /opt/pycharm/bin/pycharm.sh 2>/dev/null
