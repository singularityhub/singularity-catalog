Bootstrap: docker
from: rocker/r-ver:4.1.2

%files
    data /Project/data
    results /Project/results
    experiments /Project/experiments
    R /Project/R
    man /Project/man
    src /Project/src
    tests /Project/tests
    renv /Project/renv

    DESCRIPTION /Project/DESCRIPTION
    NAMESPACE /Project/NAMESPACE
    renv.lock /Project/renv.lock
    .Rbuildignore

    renv-cache /Project/renv-cache

%environment
    export RENV_PATHS_CACHE=/Project/renv-cache

%post
    export RENV_VERSION=0.15.1
    export RENV_PATHS_CACHE=/Project/renv-cache

    R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
    R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

    apt-get update

    apt-get install -y libopenblas-openmp-dev libopenblas0-openmp 
    apt-get remove -y libopenblas-pthread-dev libopenblas0-pthread

    apt-get install -y  \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev

    cd /Project

    R --vanilla -s -e 'renv::restore()'

    R CMD INSTALL --preclean --no-multiarch .

    chmod -R a+rX /Project

%runscript
    if [ -z "$@" ]; then
        # if there's no argument, simply test R
        R --vanilla -s -e 'sessionInfo()'
    else
        # if there's an argument, then run it and hope it's an R script
        cd /Project
        Rscript --vanilla "$@"
    fi
