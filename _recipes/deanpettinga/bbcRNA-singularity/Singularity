BootStrap: docker
From: rocker/verse:3.6.0
IncludeCmd: yes

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  # ~~~ SETUP R LIBRARY ~~~ #
  # create new directory for R Library
  mkdir ~/R_library

  # setup a new .Rprofile with new library
  echo '.libPaths("~/R_library/")' > ~/.Rprofile
  # dedicate CRAN mirror.
  echo 'local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org/"
  options(repos = r)
  })' >> ~/.Rprofile
  
  # ~~~ INSTALL R PACKAGES ~~~ #
  # bbcRNA 
  R -e 'devtools::install_github("vari-bbc/bbcRNA")'
  # Bioconductor packages
  R -e 'BiocManager::install("enrichplot", version="3.9")'
  #R -e 'BiocManager::install("org.Ag.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.At.tair.db", version="3.9")'
  #R -e 'BiocManager::install("org.Bt.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Ce.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Cf.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Dm.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Dr.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.EcK12.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.EcSakai.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Gg.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Hs.eg.db", version="3.9")'
  R -e 'BiocManager::install("org.Mm.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Mmu.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Pf.plasmo.db", version="3.9")'
  #R -e 'BiocManager::install("org.Pt.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Rn.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Sc.sgd.db", version="3.9")'
  #R -e 'BiocManager::install("org.Ss.eg.db", version="3.9")'
  #R -e 'BiocManager::install("org.Xl.eg.db", version="3.9")'
  
cat > /singularity <<'EORUNSCRIPT'
#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this text will get copied to /singularity and will run whenever the container
# is called as an executable
function usage() {
    cat <<EOF

DESCRIPTION
Singularity container for RNAseq analysis with bbcRNA package

EOF
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
