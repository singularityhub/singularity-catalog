Bootstrap: library
From: richelbilderbeek/default/plinkr:v0.15.2 

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get -y update
    apt-get -y install python3 wget
    apt-get -y clean

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
    export PATH=/miniconda/bin:$PATH
    rm Miniconda3-latest-Linux-x86_64.sh
    conda update conda

    Rscript -e 'remotes::install_github("richelbilderbeek/gcaer")'
    # Rscript -e 'reticulate::install_miniconda()'
    Rscript -e 'gcaer::install_gcae(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/gcaer"))'

%environment
    export PATH=/miniconda/bin:$PATH

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    Rscript -e 'gcaer::is_gcae_installed(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/gcaer"))'

%help

This container has the R package gcaer and GCAE installed.

To make the container run a script called, e.g. `script.R`, do:

```
cat script.R | ./gcaer.sif
```

Within the script, set `gcae_options` to `create_gcae_options(gcae_folder = "/opt/gcaer")`, for example:

```
library(gcaer)
gcae_options <- create_gcae_options(gcae_folder = "/opt/gcaer")
run_gcae(args = "--help", gcae_options = gcae_options)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME plinkr
 
    DESCRIPTION The plinkr R package, with the multiple PLINK versions installed

    USAGE simply run the container

    URL https://github.com/richelbilderbeek/plinkr

    VERSION 0.3

