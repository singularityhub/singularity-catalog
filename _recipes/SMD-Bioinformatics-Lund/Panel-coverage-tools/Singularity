Bootstrap: docker
From: python:3.11

%post
    # Update and install required tools
    apt-get -y update && apt-get -y install \
        git-all python3-pip python3.11-venv tabix bsdmainutils cargo gcc libc6-dev make
    
    # Clone and set up My-VCF-tools
    git clone https://github.com/SMD-Bioinformatics-Lund/Panel-coverage-tools /opt/Panel-coverage-tools
    python3 -m venv /opt/venv
    . /opt/venv/bin/activate

    # Build d4tools
    mkdir -p /usr/src/d4format
    cd /usr/src/d4format
    git clone https://github.com/38/d4-format .
    cargo build --release
    cp target/release/d4tools /usr/local/bin/d4tools
    chmod +x /usr/local/bin/d4tools

    # Clean up
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

%environment
    # Set up the environment
    export LC_ALL=C
    export PATH="/opt/venv/bin:$PATH"

%runscript
    #!/bin/bash
    source /opt/venv/bin/activate
    if [ "$1" = "d4tools" ]; then
        shift
        exec /usr/local/bin/d4tools "$@"
    else
        exec python3 /opt/Panel-coverage-tools/vtk "$@"
    fi

%test
    # Test Python environment
    . /opt/venv/bin/activate
    python3 --version

    # Test d4tools
    d4tools --version