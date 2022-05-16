# maintainer: Pi-Yueh Chuang <pychuang@gwu.edu>
# vim:ft=singularity

Bootstrap: docker
From: openfoam/openfoam9-paraview56:9

%setup
    if [ ! -f gmsh-4.9.5-Linux64-sdk.tgz ]; then
        curl -LO https://gmsh.info/bin/Linux/gmsh-4.9.5-Linux64-sdk.tgz
    fi

%files
    gmsh-4.9.5-Linux64-sdk.tgz /root

%post
    # fix the installation path when not using BASH nor ZSH
    sed -i "s/\[\ \"\$BASH\"\ -o\ \"\$ZSH_NAME\"\ \]\ \&\&\ \\\\//g" \
        /opt/openfoam9/etc/bashrc

    # make the singularity runtime directory if not exist
    mkdir -p /.singularity.d/env

    # make a symlink of openfoam environment
    ln -s /opt/openfoam9/etc/bashrc /.singularity.d/env/99-z-openfoam9.sh

    # extract the SDK
    cd /root && tar -xf gmsh-4.9.5-Linux64-sdk.tgz

    # move and make a shorter name
    mv gmsh-4.9.5-Linux64-sdk /opt/gmsh

    # delete the tarball
    rm /root/gmsh-4.9.5-Linux64-sdk.tgz

    # make python3 the default python
    rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

    # let sh be a symlink of bash (default sh is the symlink of dash)
    rm /bin/sh && ln -s /bin/bash /bin/sh
    

%environment
    export PYTHONPATH=/opt/gmsh/lib:$PYTHONPATH
