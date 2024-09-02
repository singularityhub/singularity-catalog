Bootstrap: docker
From: ubuntu:trusty

%setup

    cp post.sh $SINGULARITY_ROOTFS
    mkdir /scratchLocal
    mkdir /pbtech_mounts
    mkdir /pbtech_mounts/softlib001
    mkdir /pbtech_mounts/oelab_store003
    mkdir /athena
    mkdir /cluster001

%runscript

    if [ $# -eq 0 ]; then
        echo "\nThe following software is installed in this image:"
        column -t /Software/.info | sort -u --ignore-case        
        echo "\Note that some Anaconda in the list are modules and note executables."
        echo "Example usage: analysis.img [command] [args] [options]"  
    else
        exec "$@"
    fi

%test
      exec R --slave -e "library(tensorflow); \
                     sess  <- tensorflow::tf\$Session(); \
                     hello <- tensorflow::tf\$constant('Hello, TensorFlow!'); \
                     sess\$run(hello)"

%post

    chmod u+x /post.sh
    ./post.sh
     R --slave -e 'devtools::install_github("rstudio/tensorflow")'
     
