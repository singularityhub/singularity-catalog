BootStrap: docker
From: rocker/verse:3.6.0
IncludeCmd: yes

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this will install all necessary R packages and prepare the container

  R -e 'install.packages("cowplot", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("ggfortify", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("ggrepel", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("ggfortify", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("gridExtra", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("pheatmap", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("msigdbr", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("matrixStats", repos="http://cran.us.r-project.org")'
  R -e 'install.packages("vegan", repos="http://cran.us.r-project.org")'

  # Bioconductor packages
  R -e 'BiocManager::install("biomaRt", version="3.9")'
  R -e 'BiocManager::install("clusterProfiler", version="3.9")'
  R -e 'BiocManager::install("edgeR", version="3.9")'
  R -e 'BiocManager::install("AnnotationDbi", version="3.9")'

  # Annotation Packages
  R -e 'BiocManager::install("org.Ag.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.At.tair.db", version="3.9")'
  R -e 'BiocManager::install("org.Bt.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Ce.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Cf.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Dm.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Dr.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.EcK12.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.EcSakai.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Gg.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Hs.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Mm.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Mmu.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Pf.plasmo.db", version="3.9")'
  R -e 'BiocManager::install("org.Pt.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Rn.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Sc.sgd.db", version="3.9")'
  R -e 'BiocManager::install("org.Ss.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Xl.eg.db", version="3.9")'

cat > /singularity <<'EORUNSCRIPT'
#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this text will get copied to /singularity and will run whenever the container
# is called as an executable
function usage() {
    cat <<EOF

NAME


SYNOPSIS
rnaseq tool [tool options]
rnaseq list
rnaseq help

DESCRIPTION
Singularity container for edgeR RNAseq analysis

EOF
}

function tools() {
    echo "conda: $(which conda)"
    echo "---------------------------------------------------------------"
    conda list
    echo "---------------------------------------------------------------"
    echo "samtools: $(samtools --version | head -n1)"
}

export PATH="/opt/conda/bin:/usr/local/bin:/usr/bin:/bin:"
unset CONDA_DEFAULT_ENV
export ANACONDA_HOME=/opt/conda

arg="${1:-none}"

case "$arg" in
    none) usage; exit 1;;
    help) usage; exit 0;;
    list) tools; exit 0;;
    # just try to execute it then
    *)    $@;;
esac
EORUNSCRIPT
chmod 755 /singularity
