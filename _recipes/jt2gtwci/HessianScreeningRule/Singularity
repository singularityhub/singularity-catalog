Bootstrap: docker
from: rocker/r-ver:4.1.3

%files
    data /project/data
    results /project/results
    experiments /project/experiments
    R /project/R
    man /project/man
    src /project/src
    tests /project/tests
    renv /project/renv

    DESCRIPTION /project/DESCRIPTION
    NAMESPACE /project/NAMESPACE
    renv.lock /project/renv.lock
    .Rbuildignore

    renv-cache /project/renv-cache

%environment
    export RENV_PATHS_CACHE=/project/renv-cache

%post
    export RENV_VERSION=0.15.4
    export RENV_PATHS_CACHE=/project/renv-cache

    R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
    R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

    apt-get update

    apt-get install -y libopenblas-openmp-dev libopenblas0-openmp 
    apt-get remove -y libopenblas-pthread-dev libopenblas0-pthread

    apt-get install -y \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev

    cd /project

    R --vanilla -s -e 'renv::restore()'

    R CMD INSTALL --preclean --no-multiarch .

    chmod -R a+rX /project

%runscript
    if [ $# -eq 0 ]; then
        # if there's no argument, simply test R
        R --vanilla -s -e 'sessionInfo()'
    else
        # if there's an argument, then run it and hope it's an R script
        cd /project
        Rscript --vanilla "$@"
    fi
