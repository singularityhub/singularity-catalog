Bootstrap: docker
From: centos:centos8

%help
For more information, please consult https://github.com/touala/sniffles

# Add files to the container
%setup
    cp postInstall /tmp/postInstall

# Install dependencies
%post
    # Fix centos8 EOL issue
    cd /etc/yum.repos.d/
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

    # Install basic dependencies
    dnf upgrade -y
    dnf group install -y "Development Tools"
    dnf install -y python3-devel zlib-devel automake bzip2 wget git unzip

    # Define working directory
    mkdir /home/sniffles
    cd /home/sniffles

    # Install remaining dependencies
    mv /tmp/postInstall /postInstall
    bash /postInstall

    # Set default behavior
    cat > /.singularity.d/env/99-custom.sh <<EOF
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]sniffles:\[\033[33;1m\]\w\[\033[m\]$ "
SINGULARITY_SHELL=/bin/bash
EOF

%environment
    export HOME=/home/sniffles
    export PATH=/miniconda3/bin:$PATH

%runscript
    cd /home/sniffles
    exec /bin/bash
