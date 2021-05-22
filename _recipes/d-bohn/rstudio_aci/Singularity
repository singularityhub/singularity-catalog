BOOTSTRAP: docker
FROM: dalbohn/rstudio_aci

%labels
MAINTAINER Daniel Albohn <d.albohn@gmail.com>
VERSION v1.2

%post
# ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
