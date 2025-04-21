Bootstrap: docker
From: vnmd/freesurfer_8.0.0

%files
    ./src /opt/src
    ./requirements.txt /opt/requirements.txt
    ./setup.py /opt/setup.py
    ./setup.cfg /opt/setup.cfg
    ./VERSION /opt/VERSION

%post
    # Create opt directory for application code
    mkdir -p /opt
    
    # Install pip using get-pip.py
    curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
    
    # Install Python dependencies
    cd /opt
    
    # Create pip configuration to avoid building extensions
    echo "[global]" > /tmp/pip.conf
    echo "no-build-isolation = false" >> /tmp/pip.conf
    echo "only-binary = :all:" >> /tmp/pip.conf
    
    # Set the pip configuration
    export PIP_CONFIG_FILE=/tmp/pip.conf
    
    # Step 1: Install the conflicting packages with specific ordering
    # First install pynidm without dependencies
    pip install --no-deps pynidm==4.1.0 || echo "pynidm installation failed, continuing anyway"
    
    # Then install PyLD (which conflicts with pynidm's requirements)
    pip install PyLD==2.0.4 || echo "PyLD installation failed, continuing anyway"
    
    # Step 2: Install neurdflib-jsonld needed by segstats_jsonld
    pip install --no-deps neurdflib-jsonld || echo "neurdflib-jsonld installation failed, continuing anyway"
    
    # Step 3: Install the segstats_jsonld submodule
    cd src/segstats_jsonld
    pip install --no-deps -e .
    cd /opt
    
    # Step 4: Install the main requirements (without the conflicting packages)
    # Filter out PyLD and pynidm from requirements.txt before installing
    grep -v "PyLD==2.0.4" requirements.txt | grep -v "pynidm==4.1.0" > requirements_filtered.txt
    pip install --only-binary=:all: -r requirements_filtered.txt || echo "Main requirements installation failed"
    rm requirements_filtered.txt
    
    # Step 5: Install the main package
    pip install --no-deps -e . || echo "Package installation failed, trying alternative approach"
    
    # Fallback: try installing with --no-build-isolation if needed
    if [ $? -ne 0 ]; then
        pip install --no-build-isolation --only-binary=:all: -e . || echo "All installation attempts failed"
    fi
    
    # Step 6: Verify installations
    echo "Installed packages:"
    pip list

%environment
    # Set runtime license path to match BABS mount point
    export FS_LICENSE=/SGLR/FREESURFER_HOME/license.txt
    # Add opt to Python path
    export PYTHONPATH=/opt:$PYTHONPATH
    # Add Python packages to path
    export PATH=/usr/local/bin:$PATH

%runscript
    # Execute the Python entry point directly
    python3 /opt/src/run.py "$@"

%help
    FreeSurfer BIDS App 0.1.0

    This container is designed to work with BABS.

    Version Information:
    - BIDS-FreeSurfer: 0.1.0
    - FreeSurfer: 8.0.0
    - Base Image: vnmd/freesurfer_8.0.0

    Usage:
      singularity run -B [workdir] -B [license.txt]:/SGLR/FREESURFER_HOME/license.txt [container] [input_dir] [output_dir] participant --fs-license-file /SGLR/FREESURFER_HOME/license.txt [options]

    Example:
      singularity run -B $PWD -B license.txt:/SGLR/FREESURFER_HOME/license.txt freesurfer_bids_app.sif $PWD/inputs/data/BIDS $PWD/outputs/freesurfer participant --fs-license-file /SGLR/FREESURFER_HOME/license.txt --skip-bids-validation