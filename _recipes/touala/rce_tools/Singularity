Bootstrap: docker
From: centos:centos8

%help
For more information, please consult https://github.com/touala/rce_tools

# Install dependencies
%post
    # Install basic dependencies
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

    dnf upgrade -y
    dnf group install -y "Development Tools"
    dnf install -y python3-devel
    dnf install -y bzip2-devel
    dnf install -y cmake
    # dnf install -y https://extras.getpagespeed.com/release-latest.rpm
    dnf install -y protobuf
    # dnf install -y zlib-devel
    # dnf install -y git-all

    # git clone https://github.com/touala/rce_tools
    # bash rce_tools/postInstall
    pip3 install --upgrade pip
    pip3 install megalodon==2.5.0
    # pip3 install ont_pyguppy_client_lib==6.3.8

    # Define working directory
    mkdir /home/rce_tools
    cd /home/rce_tools

    # Set default behavior
    cat > /.singularity.d/env/99-custom.sh <<EOF
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]rce_tools:\[\033[33;1m\]\w\[\033[m\]$ "
SINGULARITY_SHELL=/bin/bash
EOF

%environment
    export HOME=/home/rce_tools

%runscript
    cd /home/centos8
    exec /bin/bash
