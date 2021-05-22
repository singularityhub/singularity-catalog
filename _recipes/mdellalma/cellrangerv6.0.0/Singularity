Bootstrap: docker
From: ubuntu:bionic


%post
    mkdir -p /tmp/cellranger-build \
    && cd /tmp/cellranger-build \
    && apt-get update \
    && apt-get install -y wget \
    && wget -O cellranger-6.0.0.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-6.0.0.tar.gz?Expires=1617247780&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci02LjAuMC50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MTcyNDc3ODB9fX1dfQ__&Signature=ldhwU5xhPYX1UbUv3FtvRr9jiTkkTCYNngZUpBX1QFy7qEmgKlfp-wB7N0m5haR2BBVJi8sdZJa5eRcuvlE6EMyGYSQ7wDkwsBjq0piAUe-ZWXwXh4WX1FQdt8esI-g~nqYAdUNKEm9TQ~Mc7lVEdjXVpCRyqitRqw19KJ2lBo6jOoXQipAnXXnL-9y-J9NGVGwCnBWc4ILIgsgAha1zMQqrhthWL-k7-LHvSwToEG0jc-wYcYMMMRaweB9y2M5QvUi0XZz8rR~LDkzYfPYB1qX5WKKDsHZWMPFIq~VB2-BeW9sxrAyEfJfSyidPDH42pVv4NUBXbgsU~bJnMcKGmg__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && mkdir /apps \
    && mv cellranger-6.0.0.tar.gz /apps/ \
    && cd /apps \
    && tar -xzvf cellranger-6.0.0.tar.gz \
    && rm -f cellranger-6.0.0.tar.gz \
    && rm -rf /tmp/cellranger-build

%environment
    export PATH=/apps/cellranger-6.0.0:$PATH

%labels
    Michela Dell'Alma
    Version v0.0.1
