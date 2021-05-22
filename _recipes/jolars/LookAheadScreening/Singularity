Bootstrap: docker
from: rocker/r-ver:4.0.4

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
    .Rprofile /Project/.Rprofile
    .Rbuildignore

%post
    export RENV_PATHS_CACHE="/renv/cache"

    # need to switch from pthreads to openmp to get right performance
    apt-get update
    apt-get install -y libopenblas-openmp-dev libopenblas0-openmp
    apt-get remove -y libopenblas-pthread-dev libopenblas0-pthread

    apt-get install -y  \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev

    cd Project

    Rscript -e 'renv::restore()'

    R CMD INSTALL --preclean --no-multiarch .

    chmod -R a+rX /Project

%runscript
    if [ -z "$@" ]; then
        # if there's no argument, simply test R
        Rscript -e 'sessionInfo()'
    else
        # if there's an argument, then run it and hope it's an R script
        cd /Project
        Rscript -e "source(\"$@\")"
    fi
