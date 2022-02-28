Bootstrap: docker
From: r-base

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get clean
    echo "PATH: ${PATH}"
    Rscript -e 'install.packages("stringr")'

%runscript
echo "'stringr.sif' running with arguments '$@'"
Rscript "$@"

%test
    Rscript -e 'library(stringr)'

%help

This container has the R package 'stringr' installed.

To make the container run a script called, e.g. `script.R`, do:

```
singularity run stringr.sif script.R
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME stringr
 
    DESCRIPTION The stringr R package

    USAGE run with 'singularity run stringr.sif script.R'

    URL https://github.com/richelbilderbeek/stringr_singularity

    VERSION 0.1
