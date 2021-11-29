Bootstrap: library
From: richelbilderbeek/default/plinkr:0.17.2.1

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get -y update
    apt-get -y install python3 wget
    apt-get -y clean

    # 'ormr' needs this
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
    export PATH=/miniconda/bin:$PATH
    rm Miniconda3-latest-Linux-x86_64.sh
    conda update conda

    Rscript -e 'install.packages("semver")'
    Rscript -e 'install.packages("reticulate")'
    Rscript -e 'remotes::install_github("richelbilderbeek/ormr")'
    Rscript -e 'ormr::create_conda_env(ormr_folder_name = "/opt/ormr")'
    Rscript -e 'ormr::install_python_package(ormr_folder_name = "/opt/ormr", package_name = "scipy")'
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "/opt/ormr")'
    ls /opt
    ls /opt/ormr

# 'ormr' needs this?
# export PATH=/miniconda/bin:$PATH
#
# RETICULATE_PYTHON usage is from 
# https://stackoverflow.com/questions/50145643/unable-to-change-python-path-in-reticulate
%environment
    export PATH=/opt/ormr:$PATH
    export RETICULATE_PYTHON=/opt/ormr/bin/python

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    echo "**************"
    echo "Show me '/opt'"
    echo "**************"
    ls /opt
    echo "*******************"
    echo "Show me '/opt/ormr'"
    echo "*******************"
    ls /opt/ormr
    echo "***********"
    echo "Show plinkr"
    echo "***********"
    Rscript -e 'plinkr::plinkr_report(plink_optionses = plinkr::create_plink_optionses(plink_folder = "/opt/plinkr"))'
    echo "***********************"
    echo "Run 'ormr::ormr_report'"
    echo "***********************"
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "/opt/ormr")'
    echo "******************************"
    echo "Show that the Conda env exists"
    echo "******************************"
    Rscript -e 'ormr::does_conda_env_exists(ormr_folder_name = "/opt/ormr")'
    echo "******************************"
    echo "Show that 'scipy' is installed"
    echo "******************************"
    Rscript -e 'ormr::is_python_package_installed(ormr_folder_name = "/opt/ormr", package_name = "scipy")'

%help

This container has the R package ormr installed.

To make the container run a script called, e.g. `script.R`, do:

```
cat script.R | ./ormr.sif
```

Within the script, set `ormr_folder_name` to `"/opt/ormr"`, for example:

```
library(ormr)
ormr_report(ormr_folder_name = "/opt/ormr")
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME ormr

    DESCRIPTION The ormr R package, with PLINK and the minimal ormr Python packages installed

    USAGE simply run the container

    URL https://github.com/richelbilderbeek/ormr

    VERSION 0.6.0

