Bootstrap: docker
From: xsede/centos-nix-base:latest


%runscript
    exec echo "Hello world!"
    nix-store --verify --check-contents

%test
    grep -q NAME=\"CentOS\ Linux\" /etc/os-release
    if [ $? -eq 0 ]; then
        echo "Container base is CentOS as expected."
    else
        echo "Container base is not CentOS :-("
    fi

%labels
    Author pete@XCI
    Version v0.0.1

%help
    This is a testing container for converting our base CentOS Nix
    docker image into a singularity container.



