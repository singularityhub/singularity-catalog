Bootstrap: docker 
From: ubuntu:rolling


%environment
    export LC_ALL=C
    export LANG=en_US.UTF-8

%post
    apt-get -qq update
    DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
      build-essential \
      clang \
      cmake \
      gdb \
      libtool-bin \
      llvm-dev \
      locales \
      procps \
      python3-dev \
      python3-pip \
      sqlite3 \
      strace \
      tmux \
      vim-nox
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
    NOW=`date`
    echo "export NOW=\"${NOW}\"" >> $SINGULARITY_ENVIRONMENT

%runscript
    echo "Container was created $NOW"
    echo "Arguments received: $*"
    exec echo "$@"

%startscript
    python3 -m http.server 

%test
    grep -q NAME=\"Ubuntu\" /etc/os-release
    if [ $? -eq 0 ]; then
        echo "Container base is Ubuntu as expected."
    else
        echo "Container base is not Ubuntu."
    fi

%labels
    Author jmb@iseclab.org
    MAINTAINER Josh Bundt
    Version v0.0.1

%help
    Ubuntu rolling with build tools.
