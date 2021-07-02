Bootstrap: docker
From: rootproject/root:6.24.00-ubuntu20.04 

%post
    apt update
    apt -y install --no-install-recommends fenics
    apt -y install tk-dev python3-tk vim emacs 
    apt -y install build-essential libboost-all-dev qtcreator qt5-default  
    apt -y install libgl1-mesa-dev libglu1-mesa-dev libxt-dev libxmu-dev libxi-dev zlib1g-dev libgl2ps-dev libexpat1-dev libxerces-c-dev
    
    # Will remove the plotlib later and switch to ROOT 
    #wget https://bootstrap.pypa.io/get-pip.py 
    #python3 get-pip.py
    #python3 -m pip install matplotlib



