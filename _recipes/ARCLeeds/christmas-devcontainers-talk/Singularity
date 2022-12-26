Bootstrap: docker
From: condaforge/mambaforge
Stage: spython-base

%files
    ./ /app/
%post

    mkdir -p /app/
    cd /app/

    mamba env create -f /app/environment.yml

    chmod +x /app/entrypoint.sh

    echo ". /opt/conda/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT

%runscript
    cd /app/
    exec conda run -n devcontainers "$@" 
    
%startscript
    cd /app/
    exec /app/entrypoint.sh
