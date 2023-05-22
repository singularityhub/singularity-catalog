BootStrap: docker
From: continuumio/miniconda3

#
# sudo singularity build jobmaker Singularity
#

%help
This is an example for a container with a Scientific Filesystem
that on generation, calculates the runtime for the runscript, 
and then writes a job file fitting to it. We also provide 
several wrappers (colors, fortune) for customizing the runscript.
Given that metrics for running time and memory are being calculated where
the container is built, we assume that the build environment resources 
are comparable to the running environment. The only requirements for
the running environments are that singularity is installed.
Each SCIF app serves as a different entrypoint to run the container. 

    # Generate on your own
    git clone https://www.github.com/sci-f/jobmaker.scif
    cd jobmaker.scif
    make

    # Here is how you can use the container after you build it:

    # List all apps
    ./jobmaker apps

    # Run a specific app
    ./jobmaker run <app>

    # Loop over all apps
    for app in $(./jobmaker apps); do
      ./jobmaker run $app
    done

%runscript
    if [ $# -eq 0 ]
        then
        exec scif run main "$@"
    else
        exec scif "$@"
    fi

%post
    apt-get update
    /opt/conda/bin/pip install scif
    /opt/conda/bin/scif install /jobmaker.scif
    
%files
    jobmaker.scif
    catchemall.sh
