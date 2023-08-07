Bootstrap: docker
From: continuumio/miniconda3

%files
    plot_lle_digits.py /plot_lle_digits.py

%post
    apt-get update && apt-get install -y git g++ gcc
    /opt/conda/bin/conda install numpy matplotlib scikit-learn
    git clone -b add/custom-envars https://www.github.com/vsoch/watchme
    cd watchme
    /opt/conda/bin/pip install .[all]

%environment
    WATCHMEENV_LABEL="singularity-container"
    PATH=/opt/conda/bin:$PATH
    export WATCHMEENV_LABEL PATH

%runscript
    watchme create watchme-sklearn
    /opt/conda/bin/python /plot_lle_digits.py
