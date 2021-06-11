Bootstrap: docker
From: xsede/nix-sc-benchmark:testing


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
    Author steve@XCI
    Version v0.0.2

%help
    This is a testing container for converting our base CentOS Nix
    docker image into a singularity container.



