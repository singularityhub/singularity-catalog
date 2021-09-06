Bootstrap: docker
From: rocker/r-ver:3.6.0

%labels
    Maintainer @jacobhepkema
    Version v0.1
  
%post
    apt-get update && apt-get install -y --no-install-recommends procps lbzip2 libhdf4-alt-dev libhdf5-dev libxml-parser-perl && install2.r --error BiocManager optparse stringr pracma hashmap reshape2 ggplot2 dplyr viridis gridExtra igraph ade4 && R -e "BiocManager::install(c('rhdf5', 'pheatmap', 'Biostrings', 'ggseqlogo', 'ggrepel', 'DelayedMatrixStats', 'xtable'), update=FALSE, ask=FALSE)"

# smoke test
R --version

%runscript
    exec Rscript "$@"
