Bootstrap: docker
From: centos:centos8

%help
For more information, please consult https://github.com/touala/WhatsHap

# Add files to the container
%setup
    cp postInstall /tmp/postInstall

# Install dependencies
%post
    # Install basic dependencies
    dnf check-update
    dnf upgrade -y
    dnf install -y \
        "langpacks-en" \
        "glibc-all-langpacks"

    # Define working directory
    mkdir /home/centos8
    cd /home/centos8

    # Install remaining dependencies
    mv /tmp/postInstall /postInstall
    bash /postInstall

    # Set default behavior
    cat > /.singularity.d/env/99-custom.sh <<EOF
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]centos8:\[\033[33;1m\]\w\[\033[m\]$ "
SINGULARITY_SHELL=/bin/bash
EOF

%environment
    export HOME=/home/centos8

%runscript
    cd /home/centos8
    exec /bin/bash
