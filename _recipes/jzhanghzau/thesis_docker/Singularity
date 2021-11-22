bootstrap:docker 
From:continuumio/miniconda3

%runscript
    exec echo "haha!"
%post
    apt-get update && apt-get install -y git wget python3-dev python3-pip
    /opt/conda/bin/conda install -c ankurankan pgmpy
    /opt/conda/bin/conda install pip
    /opt/conda/bin/pip install bnlearn
    /opt/conda/bin/conda install -c conda-forge networkx
    /opt/conda/bin/conda install numpy matplotlib scikit-learn 
    /opt/conda/bin/conda install -c conda-forge tensorflow
    /opt/conda/bin/conda install -c anaconda pandas
    /opt/conda/bin/conda install -c conda-forge keras
    /opt/conda/bin/conda install -c anaconda psutil
    /opt/conda/bin/conda install -c conda-forge xgboost
    /opt/conda/bin/conda install -c anaconda simplejson
    /opt/conda/bin/conda install -c conda-forge librosa
    
    
    
    
    
    
    
    
    
    
  
