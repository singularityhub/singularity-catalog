BootStrap: library
From: granek/default/singularity-rstudio-base:4.0.3

%labels
    Maintainer Josh Granek
    Image_Name rnaseq
    Image_Version rnaseq_0005

%environment
    export PATH=$PATH:/opt/bin

%post
  # Install extra stuff
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends \
    curl \
    wget \
    bzip2 \
    parallel \
    bwa \
    samtools \
    ncbi-blast+ \
    mafft \
    git \
    ssh \
    emacs \
    less \
    make \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libgsl0-dev \
    libglu1-mesa \
    seqtk \
    rna-star \
    bcftools \
    htop \
    fastqc \
    ncbi-entrez-direct \
    picard-tools
    
   #--------------------------------------------------------------------------------
   pip3 install --no-cache-dir notebook
   pip3 install --no-cache-dir bash_kernel
   python3 -m bash_kernel.install
   #--------------------------------------------------------------------------------
   Rscript -e "install.packages(c('IRkernel'), repos = 'https://cloud.r-project.org/')"
   Rscript -e "IRkernel::installspec(user = FALSE)"

   Rscript -e "install.packages(pkgs = c('argparse','R.utils','fs','here','foreach'), repos='https://mirror.las.iastate.edu/CRAN/', dependencies=TRUE, clean = TRUE)"
   Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; BiocManager::install(); BiocManager::install(c('ggbio','GenomicRanges','rtracklayer', 'DESeq2', 'Gviz'))"
   #--------------------------------------------------------------------------------
   # install fastq-mcf and fastq-multx from source since apt-get install causes problems
   #------------------
   mkdir -p /usr/bin && \
   	 cd /tmp && \
	 wget https://github.com/ExpressionAnalysis/ea-utils/archive/1.04.807.tar.gz && \
	 tar -zxf 1.04.807.tar.gz &&  \
	 cd ea-utils-1.04.807/clipper &&  \
	 make fastq-mcf fastq-multx &&  \
	 cp fastq-mcf fastq-multx /usr/bin &&  \
	 cd /tmp &&  \
	 rm -rf ea-utils-1.04.807
   #--------------------------------------------------------------------------------
   pip3 install --no-cache-dir DukeDSClient multiqc
   #--------------------------------------------------------------------------------
   
   #--------------------------------------------------------------------------------
   # Install Newer SRA toolkits than available from Ubuntu <https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit>
   #------------------
   curl -L -s https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.0/sratoolkit.2.11.0-ubuntu64.tar.gz | tar -zx
   mkdir -p /opt
   mv sratoolkit.2.11.0-ubuntu64/bin sratoolkit.2.11.0-ubuntu64/schema /opt
   rm -rf sratoolkit.2.11.0-ubuntu64
   #--------------------------------------------------------------------------------

   mkdir -p /data
   mkdir -p /workspace

   #------------------
   # Final apt cleanup
   #------------------
   apt-get clean
   rm -rf /var/lib/apt/lists/*

%apprun rscript
  exec Rscript "${@}"

%apprun jupyter
  export JUPYTER_RUNTIME_DIR="$HOME/.local/share/jupyter/runtime"
  mkdir -p $JUPYTER_RUNTIME_DIR
  jupyter notebook --no-browser --ip='0.0.0.0' "${@}"
