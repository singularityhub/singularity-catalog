Bootstrap: library
From: richelbilderbeek/default/plinkr:0.18.0.2

%post
    # Install apt
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get -y update

    # Install python3
    apt-get -y install python3 wget
    apt-get -y clean

    # Install Miniconda
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
    export PATH=/miniconda/bin:$PATH
    rm Miniconda3-latest-Linux-x86_64.sh
    conda update conda

    # Install reticulate
    Rscript -e 'install.packages("reticulate")'

    # Create the Conda environment at a system folder
    Rscript -e 'reticulate::conda_create(envname = "/opt/ormr")'
    Rscript -e 'reticulate::use_condaenv(condaenv = "/opt/ormr")'
    Rscript -e 'reticulate::use_python(python = reticulate:::python_binary_path("/opt/ormr"), required = TRUE)'
    Rscript -e 'reticulate::conda_install(packages = "scipy", envname = "/opt/ormr")'
    Rscript -e 'reticulate:::conda_list_packages(envname = "/opt/ormr")'

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    echo "******************"
    echo " test 1/4: show '/opt'"
    echo "******************"
    ls /opt
    echo "***********************"
    echo " test 2/4: show '/opt/ormr'"
    echo "***********************"
    ls /opt/ormr
    echo "*************************************"
    echo " test 3/4: run 'reticulate::use_condaenv'"
    echo "*************************************"
    Rscript -e 'reticulate::use_condaenv(condaenv = "/opt/ormr")'
    echo "********************"
    echo " test 4/4: list packages"
    echo "********************"
    Rscript -e 'reticulate:::conda_list_packages(envname = "/opt/ormr")'

%help

This container shows how to use reticulate to work with Python packages

To make the container run a script called, e.g. `script.R`, do:

```
cat script.R | ./ormr.sif
```

Use the 'ormr' R package (https://github.com/richelbilderbeek/ormr) 
to do this simpler.

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME reticulate_on_singularity

    DESCRIPTION Use reticulate on Singularity

    USAGE simply run the container

    URL https://github.com/richelbilderbeek/reticulate_on_singularity

    VERSION 0.1.0

