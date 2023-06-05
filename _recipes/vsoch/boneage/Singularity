Bootstrap: docker
From: vanessa/boneage

%runscript

  exec /usr/bin/python /code/boneage/cli.py "$@"

%labels

SINGULARITY_RUNSCRIPT_ARG_STR image,gender
SINGULARITY_RUNSCRIPT_ARG_INT demo,width,height

%post

sudo chmod o+r /usr/lib/python2.7/dist-packages/.wh*
sudo chmod o+r /usr/local/lib/python2.7/dist-packages/.wh*
