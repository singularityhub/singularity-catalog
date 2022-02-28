Bootstrap: docker
From: rocker/tidyverse

%post
    #sed -i 's/$/ universe/' /etc/apt/sources.list
    #apt-get update
    #apt-get clean
    # Rscript -e 'install.packages("stringr")'

%runscript
echo "'tidyverse.sif' running with arguments '$@'"
Rscript "$@"

%test
    Rscript -e 'library(stringr)'
    Rscript -e 'message(stringr::str_trim("   Hello world   "))'

%help

This container has the R package 'tidyverse' installed.

To make the container run a script called, e.g. `script.R`, do:

```
singularity run tidyverse.sif script.R
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME tidyverse
 
    DESCRIPTION The tidyverse R package

    USAGE run with 'singularity run tidyverse.sif script.R'

    URL https://github.com/richelbilderbeek/tidyverse_singularity

    VERSION 0.1
