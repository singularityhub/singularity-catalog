Bootstrap: docker
From: ubuntu

# This is a example comment.

%help
Help me. I'm in the container.

%setup
    touch ${SINGULARITY_ROOTFS}/tacos.txt
    touch avocados.txt

%post
    echo 'export JAWA_SEZ=wutini' >> $SINGULARITY_ENVIRONMENT
    wget https://github.com/biosugar0/singularity-vim

%runscript
    echo "Rooooar!"
    echo "Arguments received: $*"
    exec echo "$@"
