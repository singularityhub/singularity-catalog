Bootstrap: shub
From:  dcgc-bfx/dcgc-jupyter-rstudio:0.2.1

%help
  Container for single cell analysis.

  Start jupyter lab:
    singularity run --writable-tmpfs --app jupyter shub://dcgc-bfx/dcgc-single-cell

  Start rstudio server listening on port 8787:
    singularity run --writable-tmpfs --app rserver shub://dcgc-bfx/dcgc-single-cell 8787
    
%files
  tests/scanpy_test.py

%environment
  export DEBIAN_FRONTEND=noninteractive
  export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  export NUMBA_CACHE_DIR=/tmp 

%post
  SINGULARITY_BUILD_DATE=`date`
  echo "export SINGULARITY_BUILD_DATE=\"Container build date: ${SINGULARITY_BUILD_DATE}\"" >> $SINGULARITY_ENVIRONMENT

  export DEBIAN_FRONTEND=noninteractive
  export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

  # install python packages with mamba
  mamba install --quiet --yes \
    anndata \
    anndata2ri \
    bbknn \
    bioservices \
    cellrank \
    cython \
    gsl \
    h5py \
    joblib \
    leidenalg \
    libtiff=4.1 `# version 4.2 breaks plotting` \
    loompy \
    louvain \
    numba=0.52 `# version 0.53 breaks scanpy neighbors` \
    pybedtools \
    pybiomart \
    pypairs \
    pytables \
    python-igraph \
    rpy2=3.4.2 \
    scanpy \
    scikit-learn \
    scrublet \
    scvi \
    statsmodels \
    xlrd \
    xlwt \
    `# R packages` \
    bioconductor-annotationhub \
    bioconductor-biomart \
    bioconductor-clusterexperiment \
    bioconductor-complexheatmap \
    bioconductor-deseq2 \
    bioconductor-dropletutils \
    bioconductor-genomeinfodb \
    bioconductor-genomeinfodbdata \
    bioconductor-hsmmsinglecell \
    bioconductor-loomexperiment \
    bioconductor-mast \
    bioconductor-monocle \
    bioconductor-scater \
    bioconductor-scran \
    bioconductor-singlecellexperiment \
    bioconductor-slingshot \
    r-argparse \
    r-biocmanager \
    r-enrichr \
    r-factoextra \
    r-fastmatch \
    r-furrr \
    r-future \
    r-gam \
    r-ggthemes \
    r-kableextra \
    r-loomr \
    r-monocle3 \
    r-openxlsx \
    r-parallelly \
    r-pheatmap \
    r-readr \
    r-refmanager \
    r-remotes \
    r-rgl \
    r-sctransform \
    r-seurat=4 \
    r-seuratobject>=4.0.2 \
    r-spam \
    r-spatstat=1.64_1 \
    r-spatstat.core \
    r-upsetr \
    r-utf8 \
    r-venndiagram \
    `# cerebro app deps` \
    bioconductor-biocparallel \
    bioconductor-delayedarray \
    bioconductor-gseabase  \
    bioconductor-gsva \
    bioconductor-iranges \
    bioconductor-matrixgenerics \
    bioconductor-qvalue \
    bioconductor-s4vectors \
    bioconductor-glmgampoi \
    r-colourpicker \
    r-formatr \
    r-msigdbr \
    r-shinycssloaders \
    r-shinydashboard \
    r-shinyfiles \
    r-shinyjs \
    r-shinywidgets

  # clean conda cache
  mamba clean -ai --quiet --yes

  # pip
  pip -q --no-cache-dir install -U \
    fa2 \
    gprofiler-official \
    harmonypy \
    magic-impute 

  pip install -q --no-cache-dir git+https://github.com/theislab/diffxpy
  pip install -q --no-cache-dir git+https://github.com/theislab/scachepy
  pip install -q --no-cache-dir git+https://github.com/calico/solo.git

  # install R dependencies not available from conda
  R --quiet -e "devtools::install_github(repo = 'yanlinlin82/ggvenn', dependencies = FALSE, quiet = TRUE)"
  R --quiet -e 'devtools::install_github("cellgeni/sceasy", dependencies = FALSE, quiet = TRUE)'
  R --quiet -e 'remotes::install_github("chris-mcginnis-ucsf/DoubletFinder")'

  R --quiet -e 'BiocManager::install(c(
      "GenomeInfoDbData",
      "romanhaa/cerebroApp"
    ), ask = FALSE, update = FALSE, dependencies = FALSE, quiet = TRUE)'

  R --quiet -e "devtools::install_github(repo = 'cboettig/knitcitations', quiet = TRUE)"
  R --quiet -e 'install.packages(c(
        "PoiClaClu",
        "hutils",
        "singleCellHaystack"), repos="http://cran.r-project.org", quiet = TRUE)'

  chmod -R a+w /opt
  cp /root/.bashrc /.bashrc
  chmod a+rw /.bashrc

%test
  # scanpy
  bash <<-EOF
    source /.bashrc
    conda activate /opt/conda
    python /tests/scanpy_test.py
EOF
  if [ $? -eq 0 ]; then
      echo "scanpy tests passed."
  else
      echo "scanpy error."
      exit 1
  fi

  # Seurat
  bash <<-EOF
    source /.bashrc
    conda activate /opt/conda
    R --quiet -e "library(Seurat); sessionInfo()"
EOF
  if [ $? -eq 0 ]; then
      echo "Seurat tests passed."
  else
      echo "Seurat error"
      exit 1
  fi
