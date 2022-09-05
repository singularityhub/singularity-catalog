# To build the container (Singularity version 2.4):
# sudo singularity build cseq Singularity
#
# This is an example of a Singularity container delivering a specific analysis
# pipeline. We use a Scientific Filesystem to generate modules for each step
# in the container (e.g., download vs. mapping). A set of different steps 
# are installed to each app in the container based on performing a componenent 
# of the analysis. This strategy allows the creator to better represent his or 
# her specific pipeline via the container, and makes it easier for a user to 
# run (or even swap out) different steps w/o needing to know the subtle 
# details about the software relevant to each step. Notably, software that is 
# shared between steps is installed globally to the container.

Bootstrap: docker
From: continuumio/miniconda3

%runscript
    exec /bin/bash /entrypoint.sh
    

%labels
    bioRxiv-doi https://doi.org/10.1101/175281

%files
    carrierseq.scif
    python
    README.md
    reference
    entrypoint.sh

%post
    apt-get update

    # Install Shared Dependencies
    apt-get install -y git wget build-essential 
    apt-get install -y gcc-multilib apt-utils
    apt-get install -y zlib1g-dev samtools 

    # Install seqtk
    git clone https://github.com/lh3/seqtk.git build
    cd build && git checkout v1.2 && make
    mv seqtk /usr/local/bin

    # Install biopython
    /opt/conda/bin/conda install -y numpy scipy
    /opt/conda/bin/pip install biopython

    # Install Scientific Filesystem
    /opt/conda/bin/pip install scif
    /opt/conda/bin/scif install /carrierseq.scif
    chmod u+x /entrypoint.sh
