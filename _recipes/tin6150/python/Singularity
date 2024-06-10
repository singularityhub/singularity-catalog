
### https://singularity-hub.org/collections/tbd


# singularity container definition for
# python (3.8 for now)
# essentially a straight conversion from docker
# cuz somehow
# singularity pull py38.sif docker://python:3.8-alpine
# generated an error 

# container size is about 35 MB

BootStrap: docker
From: python:3.8-alpine

%post
      touch "_ROOT_DIR_OF_CONTAINER_" ## have a flag file for easy identification it is inside a container world
      date >> _ROOT_DIR_OF_CONTAINER_


%runscript
      python3 "$@"

%help
      python3 computer programming language enviroment (from docker container)


