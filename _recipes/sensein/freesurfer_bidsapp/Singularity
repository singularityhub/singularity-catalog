Bootstrap: docker
From: vnmd/freesurfer_8.0.0

%post
    # Install additional Python dependencies
    apt-get update && apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        git \
        && rm -rf /var/lib/apt/lists/*
    
    # Create app directory
    mkdir -p /app

%environment
    # Set runtime license path (for mounted license)
    export FS_LICENSE=/license.txt
    # Add app to Python path
    export PYTHONPATH=/app:$PYTHONPATH

%runscript
    # Check if we need to install the package
    if [ -f /app/setup.py ]; then
        echo "Found repository at /app, installing package..."
        cd /app && pip3 install -e .
        # Run using the installed entry point
        bids-freesurfer "$@"
    else
        echo "ERROR: Repository not found at /app"
        echo "Please bind your repository to /app using:"
        echo "singularity run --bind /path/to/repo:/app,/path/to/license.txt:/license.txt,/path/to/data:/data,/path/to/output:/output freesurfer.sif [options]"
        exit 1
    fi

%help
    FreeSurfer 8.0.0 BIDS App
    
    This container requires binding your code repository to /app
    
    Usage:
      singularity run --bind /path/to/repo:/app,/path/to/license.txt:/license.txt,/path/to/data:/data,/path/to/output:/output freesurfer.sif [options]
      
    Example:
      singularity run --bind $PWD:/app,$PWD/license.txt:/license.txt,/data:/data,/output:/output freesurfer.sif --bids_dir /data --output_dir /output