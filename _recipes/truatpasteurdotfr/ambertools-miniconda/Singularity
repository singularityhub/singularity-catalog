BootStrap: docker
From: ghcr.io/truatpasteurdotfr/ambertools-miniconda:main

%runscript
eval "$(conda shell.bash hook)" && \
conda activate AmberTools21     && \
eval "$@"

