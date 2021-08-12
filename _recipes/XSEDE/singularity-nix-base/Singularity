Bootstrap: docker
From: xsede/centos-nix-base:nix-2.3

%labels 
  base_image "centos-nix-base:v1.0.0"
  version "1.0.0"
  software "CentOS"
  software.version "7"
  about.summary "A base container with CentOS 7 and Nix 20.09"
  about.home "https://github.com/XSEDE/singularity-nix-base"
  about.documentation "https://github.com/XSEDE/singularity-nix-base"
  about.license_file "https://github.com/XSEDE/singularity-nix-base"
  about.license "MIT"
  about.tags "example-container" 
  authors "XCRI <help@xsede.org>"

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



