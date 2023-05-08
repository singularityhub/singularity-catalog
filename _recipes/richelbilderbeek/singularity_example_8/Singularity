Bootstrap: shub

From: pavel-demin/singularity-ubuntu:1804

%runscript

    ./ndsmake

%post

    apt-get update
    apt-get install --yes git libboost-all-dev
    git clone https://github.com/richelbilderbeek/ndsmake
    git clone https://github.com/richelbilderbeek/RibiClasses
    cd ndsmake
    qmake ndsmake.pro
    make

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME singularity_example_7
 
    DESCRIPTION Singularity example 6: Singularity 2.5, Ubuntu 19.04 (disco), ndsmake

    USAGE simply run the container

    URL https://github.com/richelbilderbeek/singularity_example_7

    VERSION 1.0
