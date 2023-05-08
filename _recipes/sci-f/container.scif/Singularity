BootStrap: docker
From: continuumio/miniconda3

%help
This container will say hello-world (in dinosaur)!

Examples:

     # See all installed languages
     ./<container> apps

     # See help for a specific language
     ./<container> help <language> Or

     # Run a specific languages
     ./<container> run <language>

%runscript
    exec /opt/conda/bin/scif "$@"

%post
    apt-get update && apt-get install -y wget vim curl unzip git build-essential
    apt-get install -y cpp gcc g++

    /opt/conda/bin/pip install scif
    /opt/conda/bin/scif install /hello-world.scif

%files
    hello-world.scif
    helpers /opt
    data

%environment
    # Here I have global variables for each app section to access
    DEBIAN_FRONTEND=noninteractive
    export DEBIAN_FRONTEND
