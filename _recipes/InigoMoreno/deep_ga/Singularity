BootStrap: docker
From: nvcr.io/nvidia/tensorflow:21.03-tf2-py3

%environment
    #First define the variables
    PYTHONUNBUFFERED=TRUE
    CPLUS_INCLUDE_PATH=/usr/include/gdal
    C_INCLUDE_PATH=/usr/include/gdal
    #Then export them
    export PYTHONUNBUFFERED CPLUS_INCLUDE_PATH C_INCLUDE_PATH

%post
    ln -fs /usr/share/zoneinfo/Europe/Copenhaguen /etc/localtime
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3-opencv 
    apt-get install -y libgdal-dev g++ binutils libproj-dev gdal-bin gfortran
    python -m pip install --upgrade pip
    PYTHONUNBUFFERED=TRUE
    CPLUS_INCLUDE_PATH=/usr/include/gdal
    C_INCLUDE_PATH=/usr/include/gdal
    #Then export them
    export PYTHONUNBUFFERED CPLUS_INCLUDE_PATH C_INCLUDE_PATH
    #python -m pip install gdal==2.2.3
    python -m pip install imutils numpy
    python -m pip install keras plyfile deepdiff progressbar opencv-python talos numba matplotlib GitPython
    python -m pip install --upgrade imgaug
