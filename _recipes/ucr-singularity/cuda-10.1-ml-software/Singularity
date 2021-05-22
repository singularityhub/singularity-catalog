Bootstrap: docker
From: ucrdocker/cuda-10.1-base

%post

    # Update list of available packages, then upgrade them

    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    
    # Pytorch

    apt-get install -y python-pip
    pip install --no-cache-dir https://download.pytorch.org/whl/cu100/torch-1.1.0-cp27-cp27mu-linux_x86_64.whl
    pip install --no-cache-dir torchvision

    # OpenCV dependencies
    # ===================
 
    # Developer tools
    apt-get install -y build-essential cmake unzip pkg-config
    # Image files
    apt-get install -y libjpeg-dev libpng-dev libtiff-dev
    # Video
    apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
    apt-get install -y libxvidcore-dev libx264-dev
    # GTK for GUI
    apt-get install -y libgtk-3-dev
    # Optimization
    apt-get install -y libatlas-base-dev gfortran
    # Python dev tools
    apt-get install -y python3-dev

    # Clean up
    apt-get -y autoremove
    rm -rvf /var/lib/apt/lists/*
    
