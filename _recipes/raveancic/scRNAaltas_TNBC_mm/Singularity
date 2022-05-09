Bootstrap: docker
From: ubuntu:bionic


%post
    mkdir -p /tmp/cellranger-build \
    && cd /tmp/cellranger-build \
    && apt-get update \
    && apt-get install -y wget \
    && wget -O cellranger-4.0.0.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-4.0.0.tar.gz?Expires=1605322790&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci00LjAuMC50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MDUzMjI3OTB9fX1dfQ__&Signature=neleP4grF1tzJcDEObDhTdjCIiPJvVAsyr2oKKZCF2uTCMiG0MuCeQwyInDkRN6Nk5GKZsMNdB~KuvGqjemk1HIh49F-c8Ki4G2Vat-8juueQ2ZZsOdiBtIa98q1aaZtvbvZ1FO9KidxFfAeQfnBwio~145QkQEqN97-gaEdaZESSCt97VFblIbdBGP52QBHXy7fl5XRXvr1IGP8RceXKxIOvCkmJVJj39CHkitXJ00ySc8WFdEb3KpvDbDx8FRBz1-XhSZMtICReAB7-8ZeMqbqYj4VlVCPNoPI06CM9H7RLqSdyMQw3nsUko3Woewh~bXB2TBTLalE2XWi-Hktgw__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && mkdir /apps \
    && mv cellranger-4.0.0.tar.gz /apps/ \
    && cd /apps \
    && tar -xzvf cellranger-4.0.0.tar.gz \
    && rm -f cellranger-4.0.0.tar.gz \
    && rm -rf /tmp/cellranger-build

%environment
    export PATH=/apps/cellranger-4.0.0:$PATH

%labels
    Alessandro Raveane
    Version v0.0.1

