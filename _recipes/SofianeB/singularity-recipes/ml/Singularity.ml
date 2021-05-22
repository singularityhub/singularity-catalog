Bootstrap: docker
From: continuumio/miniconda3:4.6.14

%labels
MAINTAINER SofianeB

%environment    
    # conda
    export PATH="/opt/conda/bin:/usr/local/bin:/usr/bin:/bin:"
    unset CONDA_DEFAULT_ENV
    export ANACONDA_HOME=/opt/conda


%post
    # update and install pip
    apt-get -y update

    # clean apt
    apt-get autoremove -y
    apt-get clean

    # install packages
    export PATH=/opt/conda/bin:$PATH
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda install --yes jupyter
    conda install --yes jupyterlab
    conda install --yes intake-esm
    conda clean --index-cache --tarballs --packages --yes

%runscript
    echo "Starting the notebook ..."
    echo "Open browser to localhost:8888"
    exec /opt/conda/bin/jupyter notebook --ip='*' --port=8888 --no-browser

