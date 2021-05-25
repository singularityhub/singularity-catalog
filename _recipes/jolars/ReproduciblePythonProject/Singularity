Bootstrap: docker
from: python:3.9.5

%files
    data /Project/data
    results /Project/results
    experiments /Project/experiments
    example_module /Project/example_module

    Pipfile /Project/Pipfile
    Pipfile.lock /Project/Pipfile.lock

%environment
    EIG_VER=3.3.9

%post
    export EIG_VER=3.3.9

    apt-get update
    apt-get install -y  \
        wget \
        cmake \
        gzip \
        libopenblas-dev \
        libeigen3-dev

    # install pipenv
    pip install pipenv

    # intall latest version of Eigen
    mkdir -p /tmp/eigen_build_dir
    cd /tmp/eigen_build_dir
    wget https://gitlab.com/libeigen/eigen/-/archive/$EIG_VER/eigen-$EIG_VER.tar.gz
    tar xvzf eigen-$EIG_VER.tar.gz
    cmake eigen-$EIG_VER
    make install

    # symbolically link Eigen to the directory pybind11 expects
    ln -s /usr/include/eigen3/Eigen /usr/include/Eigen

    chmod -R a+rX /Project

    cd /Project

    pipenv install

%runscript
    cd /Project
    if [ -z "$@" ]; then
        pipenv run python --version
    else
        pipenv run python $@
    fi
