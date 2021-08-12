BootStrap: shub
From: tpall/singularity-r:4.0.3

%labels
  Author Sylvain Schmitt

%help
  This will run tidyverse and Biostrings

%post
  apt-get update -qq \
    && apt-get install -y \
    --no-install-recommends \
    libudunits2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libgdal-dev \
    libgsl-dev \
    libnode-dev \
    && Rscript -e "install.packages(c('tidyverse', 'BiocManager', 'vroom', 'vcfR', 'devtools', 'reshape2'), dependencies = c('Depends', 'Imports', 'LinkingTo'))" \
    && Rscript -e "BiocManager::install('Biostrings')" \
    && Rscript -e "devtools::install_github('kcf-jackson/csv2sql')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
