Bootstrap: docker
From: twongjirad/docker-ubuntu16.04-root:6.12.04_cuda8.0

%post
  export USER=<yournamehere>
  cp /tmp/$USER/krb5.conf /etc/
  cp -r /tmp/$USER/grid-security /etc/
  cp /tmp/$USER/vomses /etc/
  apt-get update -y
  apt-get install -y voms-clients krb5-user jacksum emacs vim  
  mkdir -p /cluster/home
  mkdir -p /cluster/kappa
  mkdir -p /cluster/shared
  mkdir -p /opt/shared

%environment
