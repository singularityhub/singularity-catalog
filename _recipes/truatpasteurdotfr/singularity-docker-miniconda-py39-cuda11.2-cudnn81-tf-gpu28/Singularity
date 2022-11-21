BootStrap: docker
From: ghcr.io/truatpasteurdotfr/singularity-docker-miniconda-py39-cuda11.2-cudnn81-tf-gpu28:main

%post
date +"%Y-%m-%d-%H%M" > /last_update

%runscript
export	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/envs/tf/lib/:/opt/conda/lib
eval "$(conda shell.bash hook)" && \
conda activate n2v && \
"$@"
