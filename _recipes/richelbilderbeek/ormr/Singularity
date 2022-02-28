Bootstrap: library
From: richelbilderbeek/default/plinkr:0.19

%post
    # Install python3
    apt-get update
    apt-get install -y git wget python3-pip

    # python3 -m pip install --upgrade pip
    # Tip from Pavlin Mitev
    python3 -m pip install --no-cache-dir --upgrade pip

    apt-get -y clean

    # echo "********************************"
    # echo "Install conda: 'ormr' needs this"
    # echo "********************************"
    # wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    # bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
    # export PATH=/miniconda/bin:$PATH
    # rm Miniconda3-latest-Linux-x86_64.sh
    # conda update conda

    echo "******************"
    echo "Install R packages"
    echo "******************"
    Rscript -e 'install.packages(c("remotes", "reticulate", "semver"))'
    Rscript -e 'remotes::install_github("richelbilderbeek/ormr")'
    Rscript -e 'devtools::session_info()'

    echo "*******************************************"
    echo "Report before Python packages are installed"
    echo "*******************************************"
    # Rscript -e 'ormr::ormr_report(ormr_folder_name = "/opt/ormr", verbose = TRUE)'
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "python3", verbose = TRUE)'

    echo "***********************"
    echo "Install Python packages"
    echo "***********************"
    # Rscript -e 'ormr::install_python_package(ormr_folder_name = "/opt/ormr", package_name = "scipy")'
    Rscript -e 'ormr::install_python_package(ormr_folder_name = "python3", package_name = "scipy")'

    echo "******"
    echo "Report"
    echo "******"
    # Rscript -e 'ormr::ormr_report(ormr_folder_name = "/opt/ormr")'
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "python3")'

%runscript
echo "'ormr.sif' running with arguments '$@'"
Rscript "$@"

%test
    # echo "*******************************"
    # echo "Show list of Conda environments"
    # echo "*******************************"
    # conda-env list
    echo "***********"
    echo "Show plinkr"
    echo "***********"
    # Rscript -e 'plinkr::plinkr_report(plink_optionses = plinkr::create_plink_optionses(plink_folder = "/opt/plinkr"))'
    Rscript -e 'plinkr::plinkr_report(plink_optionses = plinkr::create_plink_optionses(plink_folder = "python3"))'
    echo "********************************"
    echo "Run 'ormr::ormr_report'"
    echo "********************************"
    # Rscript -e 'ormr::ormr_report(ormr_folder_name = "/opt/ormr", verbose = TRUE)'
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "python3", verbose = TRUE)'
    echo "******************************"
    echo "Show that 'scipy' is installed"
    echo "******************************"
    # Rscript -e 'ormr::is_python_package_installed(ormr_folder_name = "/opt/ormr", package_name = "scipy", verbose = TRUE)'
    Rscript -e 'ormr::is_python_package_installed(ormr_folder_name = "python3", package_name = "scipy", verbose = TRUE)'

%help

This container has the R package ormr installed.

To make the container run a script called, e.g. `script.R`, do:

```

cat script.R | ./ormr.sif
```

The container can be run with and without conda.

When you do not want to use conda,
within the script, set `ormr_folder_name` to `"python3"`, for example:

```
library(ormr)
ormr_report(ormr_folder_name = "python3")
```

When you want to use conda, 
within the script, set `ormr_folder_name` to `"/opt/ormr"`, for example:

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

    VERSION 0.6.2.2

