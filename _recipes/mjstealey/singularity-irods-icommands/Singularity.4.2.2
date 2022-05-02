Bootstrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%help
  iRODS Version 4.2.2

  $ singularity run icommands.4.2.2.simg [icommand] [args]
  $ singularity run --app iinit icommands.4.2.2.simg
  $ singularity run --app iinit icommands.4.2.2.simg [args]
    Where [args] in
    --irods_host String
    --irods_port Integer
    --irods_user_name String
    --irods_zone_name String
    --irods_password String
    --irods_default_resource String
    --irods_home String

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/code

%files
  iinit.sh /code/iinit.sh

%labels
  Maintainer Michael J. Stealey
  Maintainer_Email stealey@renci.org
  iRODS_Version 4.2.2

%environment
  export IRODS_VERSION=4.2.2

%post
  export IRODS_VERSION=4.2.2
  apt-get update
  apt-get install -y \
    wget \
    sudo \
    apt-transport-https
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  chmod +x jq-linux64
  mv jq-linux64 /usr/bin/jq
  wget -qO - https://packages.irods.org/irods-signing-key.asc | \
    sudo apt-key add -
  echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" | \
    sudo tee /etc/apt/sources.list.d/renci-irods.list
  apt-get update
  apt-get install -y \
    irods-icommands=${IRODS_VERSION} \
    libxml2

%apprun iinit
  exec /bin/bash /code/iinit.sh "${@}"

%runscript
  exec "${@}"

%test
  exec ihelp
