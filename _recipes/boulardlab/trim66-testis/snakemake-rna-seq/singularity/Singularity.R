Bootstrap: docker
From: r-base:4.0.3

%labels
    MAINTAINER francesco.tabaro@embl.it
    VERSION 1.0

%environment
    export LC_ALL=C
    export LC_CTYPE=C
    export LC_COLLATE=C
    export LC_TIME=C
    export LC_MESSAGES=C
    export LC_MONETARY=C
    export LC_PAPER=C
    export LC_MEASUREMENT=C

%post
    apt-get update && apt-get install -y libssl-dev libxml2-dev libcurl4-openssl-dev pandoc

    mkdir ~/.R && echo "MAKEFLAGS=-j16" > ~/.R/Makevars
    R --slave -e 'install.packages(c("hexbin", "data.table", "pheatmap", "Hmisc", "latticeExtra", "R.utils", "scales", "RCurl", "ggplot2", "BiocManager", "openxlsx", "knitr", "rmarkdown", "tidyverse"), repos="https://cloud.r-project.org/")' && \
    R --slave -e 'BiocManager::install(c("DESeq2", "rtracklayer", "topGO", "vsn", "apeglm"))' && \
    R --slave -e 'BiocManager::install("ReactomePA", method="wget")'

%test

    R --slave -s -e 'library(Hmisc)' &>/dev/null && echo "Hmisc OK" || echo "Error loading Hmisc"
    R --slave -s -e 'library(latticeExtra)' &>/dev/null && echo "latticeExtra OK" || echo "Error loading latticeExtra"
    R --slave -s -e 'library(R.utils)' &>/dev/null && echo "R.utils OK" || echo "Error loading R.utils"
    R --slave -s -e 'library(scales)' &>/dev/null && echo "scales OK" || echo "Error loading scales"
    R --slave -s -e 'library(RCurl)' &>/dev/null && echo "RCurl OK" || echo "Error loading RCurl"
    R --slave -s -e 'library(ggplot2)' &>/dev/null && echo "ggplot2 OK" || echo "Error loading ggplot2"
    R --slave -s -e 'library(openxlsx)' &>/dev/null && echo "openxlsx OK" || echo "Error loading openxlsx"
    R --slave -s -e 'library(DESeq2)' &>/dev/null && echo "DESeq2 OK" || echo "Error loading DESeq2"
    R --slave -s -e 'library(rtracklayer)' &>/dev/null && echo "rtracklayer OK" || echo "Error loading rtracklayer"
    R --slave -s -e 'library(topGO)' &>/dev/null && echo "topGO OK" || echo "Error loading topGO"
    R --slave -s -e 'library(ReactomePA)' &>/dev/null && echo "ReactomePA OK" || echo "Error loading ReactomePA"
    R --slave -s -e 'library(knitr)' &>/dev/null && echo "knitr OK" || echo "Error loading knitr"
    R --slave -s -e 'library(rmarkdown)' &>/dev/null && echo "rmarkdown OK" || echo "Error loading rmarkdown"
    R --slave -s -e 'library(vsn)' &>/dev/null && echo "vsn OK" || echo "Error loading vsn"
    R --slave -s -e 'library(data.table)' &>/dev/null && echo "data.table OK" || echo "Error loading data.table"
    R --slave -s -e 'library(pheatmap)' &>/dev/null && echo "pheatmap OK" || echo "Error loading pheatmap"
    R --slave -s -e 'library(apeglm)' &>/dev/null && echo "apeglm OK" || echo "Error loading apeglm"
    R --slave -s -e 'library(hexbin)' &>/dev/null && echo "hexbin OK" || echo "Error loading hexbin"
