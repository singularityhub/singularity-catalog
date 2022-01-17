Bootstrap: docker
From: base/archlinux

%runscript
    exec jupyter-notebook

%setup
    # Mirror list
    echo 'Server = http://mirror.cs.pitt.edu/archlinux/$repo/os/$arch' > $SINGULARITY_ROOTFS/etc/pacman.d/mirrorlist
    echo 'Server = http://mirrors.rit.edu/archlinux/$repo/os/$arch' >> $SINGULARITY_ROOTFS/etc/pacman.d/mirrorlist
    echo 'Server = http://mirror.es.its.nyu.edu/archlinux/$repo/os/$arch' >> $SINGULARITY_ROOTFS/etc/pacman.d/mirrorlist
    echo 'Server = http://mirrors.rutgers.edu/archlinux/$repo/os/$arch' >> $SINGULARITY_ROOTFS/etc/pacman.d/mirrorlist

    # NVidia
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.20/NVIDIA-Linux-x86_64-375.20.run
    sh NVIDIA-Linux-x86_64-375.20.run -x
    mv NVIDIA-Linux-x86_64-375.20 $SINGULARITY_ROOTFS/usr/local
    cp links.sh $SINGULARITY_ROOTFS/root

    # CuDNN
    mkdir $SINGULARITY_ROOTFS/usr/local/cuda
    cp -R cudnn/* $SINGULARITY_ROOTFS/usr/local/cuda

    # CUDA
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
    dir=$(pwd)
    sh cuda_8.0.61_375.26_linux-run -extract=$dir/cuda
    $dir/cuda/cuda-linux64-rel-8.0.61-21551265.run --noexec --keep
    cp -R $dir/pkg/lib64/* $SINGULARITY_ROOTFS/usr/local/cuda/lib64

    # Cleanup
    rm -rf NVIDIA-Linux-x86_64-375.20.run cuda_8.0.61_375.26_linux-run cuda pkg

%environment
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/NVIDIA-Linux-x86_64-375.20:$LD_LIBRARY_PATH
    export PATH=/usr/local/NVIDIA-Linux-x86_64-375.20:$PATH
    unset XDG_RUNTIME_DIR

%labels
    AUTHOR barrymoo

%post
    # Process NVIDIA links
    sh /root/links.sh 375.20

    # Install python and pip
    pacman -Syy --noconfirm python python-pip

    # Install tensorflow
    pip install --upgrade tensorflow-gpu

    # Get JupyterHub
    pip install --upgrade jupyterhub jupyter

    # Get NPM, and configurable-http-proxy
    pacman -S --noconfirm npm
    npm install -g configurable-http-proxy
