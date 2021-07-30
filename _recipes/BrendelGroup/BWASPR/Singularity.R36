bootstrap: docker
From: ubuntu:18.04

%help
    This container is a companion to BWASP: Bisulfite-seq data Workflow Automation
    Software and Protocols from the Brendel Group, providing R packages and scripts
    for BWASP data analyses.
    Please see https://github.com/BrendelGroup/BWASPR for complete documentation.

%post
    export DEBIAN_FRONTEND=noninteractive
    apt -y update
    apt-get -y upgrade
    apt -y install bc git tcsh unzip zip wget tzdata \
                   build-essential \
                   openjdk-11-jdk \
                   software-properties-common \
                   libcairo2-dev \
                   libcurl4-gnutls-dev \
                   libgd-dev \
                   libgd-graph-perl \
                   libmariadb-client-lgpl-dev \
                   libpq-dev \
                   libssl-dev \
                   libtbb-dev \
                   libxml2-dev \
                   poppler-utils


    echo 'Installing R'
    #### 
    add-apt-repository -y ppa:marutter/rrutter3.5
    add-apt-repository -y ppa:marutter/c2d4u3.5
    apt -y update
    apt -y install r-base-core r-base-dev
    R CMD javareconf

    echo 'Installing CRAN packages'
    ######
    apt -y install r-cran-biocmanager
    apt -y install r-cran-dplyr
    apt -y install r-cran-gplots
    apt -y install r-cran-gridextra
    apt -y install r-cran-pastecs
    apt -y install r-cran-rjava
    apt -y install r-cran-sqldf
    apt -y install r-cran-venneuler
    apt -y install r-cran-rcurl
    apt -y install r-cran-xml
   
    echo 'Installing other CRAN and Bioconductor packages'
    ######
    echo 'install.packages("R.devices", repos="http://ftp.ussg.iu.edu/CRAN", dependencies=TRUE)'             > R2install
    echo 'BiocManager::install(c("BiocGenerics", "GenomicRanges", "genomation","methylKit"), ask=FALSE)'    >> R2install

    Rscript R2install

    echo 'Installing BWASPR from https://github.com/BrendelGroup/BWASPR/ '
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/BWASPR.git
    R CMD INSTALL BWASPR


%environment
    export LC_ALL=C

%labels
    Maintainer vpbrendel
    Version v1.0
