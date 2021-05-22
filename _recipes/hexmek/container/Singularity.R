Bootstrap: docker
From: r-base:3.6.1

%post
    apt update 
    apt upgrade -y
    apt install -y procps
    # install all CRAN packages and biocondocutor we need
    echo '''
        #!/usr/bin/env Rscript
        list.of.packages <- c("tidyverse", "Rtsne", "cowplot", "optparse", "umap", "viridis", "ggsci", "cowplot")
        new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
        if(length(new.packages)) install.packages(new.packages, dependencies=TRUE, repos="http://cran.rstudio.com/")

        if (!requireNamespace("BiocManager", quietly = TRUE))
           install.packages("BiocManager")

        BiocManager::install("preprocessCore")
        BiocManager::install("ComplexHeatmap")

        ''' > install.R
    Rscript install.R
    

    


%environment
    export LC_ALL=C

