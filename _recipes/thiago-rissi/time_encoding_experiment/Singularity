Bootstrap: docker
From: python:3.11

%files
    # Copy your application's source code from host to container
    src /usr/src/code/src
    conf /usr/src/code/conf
    requirements.txt /usr/src/code/requirements.txt
    requirements-torch.txt /usr/src/code/requirements-torch.txt
    
%post
    # Install necessary packages
    apt-get update && apt-get install -y \
        wget


    # Create the working directory
    mkdir -p /usr/src/code/

    # Install Python dependencies
    # Note: The 'requirements.txt' files need to be available in the container
    # You can add them using %files section or download them in this section

    python -m pip install -r /usr/src/code/requirements.txt
    python -m pip install -r /usr/src/code/requirements-torch.txt
        
        

%runscript
    # The runscript is executed when you run the container without specifying a command
    exec tail -f /dev/null

%startscript
    # The startscript is executed when you start an instance of the container
    exec tail -f /dev/null

%help
    This container includes a Python 3.11 environment with specific packages installed. 
    To run a Python script, use: 
    `singularity exec --bind /your/host/dir:/usr/src/code your_image.sif python /usr/src/code/src/your_script.py`
