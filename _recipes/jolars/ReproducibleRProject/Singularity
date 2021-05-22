Bootstrap: docker
from: rocker/r-ver:4.0.4

%files
    data /Project/data
    results /Project/results
    experiments /Project/experiments
    R /Project/R
    renv /Project/renv
    PackageName /Project/PackageName

    renv.lock /Project/renv.lock
    .Rprofile /Project/.Rprofile

%post
    export RENV_PATHS_CACHE="/renv/cache"

    # make user openblas-openmp is used and not pthreads
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

    R CMD INSTALL --preclean --no-multiarch PackageName

    chmod -R a+rX /Project

%runscript
    cd /Project
    if [ -z "$@" ]; then
        # if there's no argument, test is we can run R
        Rscript -e 'sessionInfo()'
    else
        # if there's an argument, run it
        Rscript -e "source(\"$@\")"
    fi
