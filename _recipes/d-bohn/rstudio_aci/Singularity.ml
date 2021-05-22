
BOOTSTRAP: docker
FROM: rocker/tensorflow-gpu

%labels
MAINTAINER Daniel Albohn <d.albohn@gmail.com>

%post
# ACI mappings so you can access your files
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/scratch
