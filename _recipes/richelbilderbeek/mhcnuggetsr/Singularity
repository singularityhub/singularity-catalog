# The mhcnuggetsr R package, with MHCnuggets installed

Bootstrap: docker
From: r-base

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get -y install libssl-dev libcurl4-openssl-dev libxml2-dev r-cran-stringi libicu-dev git
    apt-get clean

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
    export PATH=/miniconda/bin:$PATH
    rm Miniconda3-latest-Linux-x86_64.sh
    conda update conda

    Rscript -e 'install.packages(c("remotes", "devtools"))'
    Rscript -e 'remotes::install_github("richelbilderbeek/mhcnuggetsr")'
    Rscript -e 'mhcnuggetsr::install_mhcnuggets(folder_name = "/opt/mhcnuggetsr")'

%environment
    export PATH=/miniconda/bin:$PATH

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    Rscript -e 'mhcnuggetsr::mhcnuggetsr_report(folder_name = "/opt/mhcnuggetsr")'

%help

This container has the R package mhcnuggetsr and MHCnuggets installed.

To make the container run a script called, e.g. `script.R`, do:

```
cat script.R | ./mhcnuggetsr.sif
```

Within the script, set `folder_name` to `/opt/mhcnuggetsr`, for example:

```
library(mhcnuggetsr)
mhcnuggetsr_report(folder_name = "/opt/mhcnuggetsr")
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME mhcnuggetsr
 
    DESCRIPTION The mhcnuggetsr R package, with MHCnuggets installed

    USAGE send the R stcript as text to the container

    URL https://github.com/richelbilderbeek/mhcnuggetsr

    VERSION 1.2
