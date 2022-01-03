Bootstrap: docker
From: openfoam/openfoam5-paraview54:latest

%post
    # Setup a very minimal bashrc file
    echo 'source /opt/openfoam5/etc/bashrc' > /opt/bashrc
    echo 'PS1="$WM_PROJECT-$WM_PROJECT_VERSION \W> "' >> /opt/bashrc
    
    # Remove the Docker environment definition file which defines $HOME etc
    mv /.singularity.d/env/10-docker.sh /.singularity.d/env/10-docker.sh_DISABLED

%runscript
    echo "Welcome to the OpenFOAM Singularity container!"
    
    # Disable annoying sudo message
    touch ~/.sudo_as_admin_successful
    
    exec /bin/bash --rcfile /opt/bashrc "$@"
