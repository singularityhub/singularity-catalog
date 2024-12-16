lsBootStrap: docker
From: continuumio/miniconda3

%post
    # Update pip
     python -m pip install --upgrade pip
    # Set environment variable to allow deprecated sklearn package install
    export SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

    # Install Jupyter notebook
    conda install jupyter -y
    mkdir /opt/notebooks

    # Generate Jupyter notebook config
     jupyter notebook --generate-config

    # Set up Sklearn environment
     conda create -n sklearn -y scikit-learn
     conda install -n sklearn -y -c anaconda ipykernel
     conda/envs/sklearn/bin/python -m ipykernel install --user --name=sklearn
     conda install -n sklearn -y -c conda-forge optuna
     conda install -n sklearn -y -c conda-forge configargparse
     conda install -n sklearn -y pandas

    # Set up GBDT environment
     conda create -n gbdt -y
     conda install -n gbdt -y -c anaconda ipykernel
    /opt/conda/envs/gbdt/bin/python -m ipykernel install --user --name=gbdt
    /opt/conda/envs/gbdt/bin/python -m pip install xgboost==1.5.0
    /opt/conda/envs/gbdt/bin/python -m pip install catboost==1.2.3
    /opt/conda/envs/gbdt/bin/python -m pip install lightgbm==3.3.1
     conda install -n gbdt -y -c conda-forge optuna
     conda install -n gbdt -y -c conda-forge configargparse
     conda install -n gbdt -y pandas
    /opt/conda/envs/gbdt/bin/python -m pip install https://github.com/schufa-innovationlab/model-trees/archive/master.zip

    # Set up Pytorch environment
     conda create -n torch -y pytorch cudatoolkit=11.3 -c pytorch
     conda install -n torch -y -c anaconda ipykernel
     conda install -n torch -y -c conda-forge optuna
     conda install -n torch -y -c conda-forge configargparse
     conda install -n torch -y scikit-learn
     conda install -n torch -y pandas
     conda install -n torch -y matplotlib
     conda install -n torch -y -c pytorch captum
     conda install -n torch -y shap
    /opt/conda/envs/gbdt/bin/python -m ipykernel install --user --name=torch
    /opt/conda/envs/torch/bin/python -m pip install pytorch-tabnet
    /opt/conda/envs/torch/bin/python -m pip install requests
    /opt/conda/envs/torch/bin/python -m pip install qhoptim
    /opt/conda/envs/torch/bin/python -m pip install lightgbm==3.3.1
    /opt/conda/envs/torch/bin/python -m pip install einops

    # Set up Keras environment
     conda create -n tensorflow -y tensorflow-gpu=1.15.0 keras
     conda install -n tensorflow -y -c anaconda ipykernel
     conda install -n tensorflow -y -c conda-forge optuna
     conda install -n tensorflow -y -c conda-forge configargparse
     conda install -n tensorflow -y scikit-learn
     conda install -n tensorflow -y pandas
    /opt/conda/envs/torch/bin/python -m pip install stg==0.1.2
    /opt/conda/envs/torch/bin/python -m pip install tabulate
    /opt/conda/envs/torch/bin/python -m pip install yacs

    # Download code into container
    git clone https://github.com/kathrinse/TabSurvey.git /opt/notebooks

%runscript
    # Start Jupyter notebook
    exec  jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=3123 --no-browser --allow-root
