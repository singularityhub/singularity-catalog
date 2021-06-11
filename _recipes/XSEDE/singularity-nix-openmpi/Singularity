Bootstrap: docker
From: xsede/centos-nix-openmpi:latest


%runscript
    #nix-store --verify --check-contents
    nix-shell /root/dev.nix

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
    This is a testing container for OpenMPI in a docker image
    based on CentOS with Nix converted to a singularity container.
    Original dockerfile from:
    https://github.com/XSEDE/docker-centos-nix-openmpi



