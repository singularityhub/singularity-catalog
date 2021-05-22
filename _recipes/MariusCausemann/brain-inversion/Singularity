#Bootstrap: docker
Bootstrap: docker-daemon
#From: multiphenics/multiphenics
#From: fenics/openmp:openblas
From: fenics/openmp:mkl

%environment
    PYTHONPATH=/usr/local/lib/python3/dist-packages/gmsh-4.6.0-Linux64-sdk/lib/
    export PYTHONPATH
    DISPLAY=:99.0
    PYVISTA_OFF_SCREEN=true
    PYVISTA_USE_PANEL=false

%post
    chmod -R 777 var/*
    pip3 -q install --upgrade --no-cache-dir pip meshio==4.0.13 jdata pyvista gmsh pygmsh pyyaml cmocean imageio-ffmpeg