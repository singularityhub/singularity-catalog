Bootstrap: docker

From: continuumio/miniconda3

###########
## See https://stackoverflow.com/questions/54678805/containerize-a-conda-environment-in-a-singularity-container for tips on how to make this
###########

%files
    environment.yml

%environment
    PATH=/opt/conda/envs/$(head -1 environment.yml | cut -d' ' -f2)/bin:$PATH
    
%post
    bash -c echo ##Just a dummy line, to help initialize bash?
    /opt/conda/bin/conda init bash
    echo ". /opt/conda/etc/profile.d/conda.sh" >> environment
    echo "conda activate $(head -1 environment.yml | cut -d' ' -f2)" >> environment
    /opt/conda/bin/conda env create -f environment.yml

%runscript
    exec "$@"
