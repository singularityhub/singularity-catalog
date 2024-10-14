Bootstrap: docker
From: rocker/r-ver:4.3.0

%post
    # Install system utilities and dependencies for R packages
    apt-get update && apt-get install -y \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        wget \
        vim \
        less \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

    # Ensure output directory is created and has proper permissions
    mkdir -p /usr/src/app/output
    # chmod 777 /usr/src/app/output  # Make the output directory writable by any user

    # Install R packages from CRAN
    R -e "install.packages(c('dplyr', 'ggplot2', 'ggrepel', 'testthat'), repos='http://cran.rstudio.com/')"

    # Install qvalue from Bioconductor
    R -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
    R -e "BiocManager::install('qvalue')"

    # Create working directory
    mkdir -p /usr/src/app

    # Download R scripts and data
    wget https://raw.githubusercontent.com/J-Andy/eQTL-analysis/main/main.R -O /usr/src/app/main.R
    wget https://raw.githubusercontent.com/J-Andy/eQTL-analysis/main/unit_tests.R -O /usr/src/app/unit_tests.R
    wget https://raw.githubusercontent.com/J-Andy/eQTL-analysis/main/Gene_KOs.tsv -O /usr/src/app/Gene_KOs.tsv
    wget https://raw.githubusercontent.com/J-Andy/eQTL-analysis/main/Mutations.tsv -O /usr/src/app/Mutations.tsv

%environment
    # Set the working directory and environment variables inside the container
    export R_LIBS_USER=/usr/local/lib/R/site-library
    export WORKDIR=/usr/src/app

%runscript
    # Command to run the R script when the container starts
    cd /usr/src/app
    exec Rscript main.R