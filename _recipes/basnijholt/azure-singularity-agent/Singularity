BootStrap: docker
From: jupyter/minimal-notebook

%files
    start.sh /azp/start.sh

%post
    echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
    apt-get update && apt-get install software-properties-common
    add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
      apt-get update && \
      apt-get install -y --no-install-recommends \
          ca-certificates \
          curl \
          jq \
          git \
          iputils-ping \
          libcurl4 \
          libicu55 \
          libunwind8 \
          netcat

%environment
    export XDG_RUNTIME_DIR=""
    export DEBIAN_FRONTEND=noninteractive

%runscript
    echo "Starting the Agent"
    ./start.sh

%labels
    Author Bas Nijholt <bas@nijho.lt>
