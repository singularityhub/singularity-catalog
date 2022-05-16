BootStrap: docker
From: ghcr.io/truatpasteurdotfr/bioconda-perl-bioperl:main

%environment
# do not use ~/.local python
PYTHONNOUSERSITE=1 
export PYTHONNOUSERSITE

eval "$(conda shell.bash hook)" && \
conda activate bioperl

