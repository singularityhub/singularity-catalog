Bootstrap: docker
From: continuumio/miniconda3

%files
    environment.yml

%environment
    PATH=/opt/conda/bin:$PATH
    PATH=/opt/conda/envs/Sauron.v1/bin:$PATH

%post
    /opt/conda/bin/conda env create -n Sauron.v1 -f environment.yml
    /opt/conda/bin/conda clean -afy
    cat ~/.bashrc
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
    echo "source activate Sauron.v1" >> ~/.bashrc
    
%runscript
  exec "$@"
