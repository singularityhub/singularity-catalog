Bootstrap: docker
From: rocker/r-ubuntu:22.04

%post

# automake bzip2 wget unzip 
apt-get update \
    && apt-get install -y --no-install-recommends build-essential automake bzip2 wget unzip \
    python3 python3-dev python3-pip python3-venv git git-lfs default-jdk ant \
    libbz2-dev libsdl1.2-dev liblzma-dev libcurl4-openssl-dev zlib1g-dev libxml2-dev \
	r-cran-tidyverse bwa samtools multiqc datamash && rm -rf /var/lib/apt/lists/*

# CONDA 
%environment
export PATH=/miniconda3/bin:$PATH
%runscript 
exec vcontact "$@"
# Install miniconda 
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p /miniconda3/
rm Miniconda3-latest-Linux-x86_64.sh
# pull the conda functions in . /miniconda3/etc/profile.d/conda.sh and make pip, etc. available while in %post
export PATH="/miniconda3/bin:$PATH"
# Use conda to install trimmomatic, gatk, fastqc
conda install -y -c conda-forge -c bioconda trimmomatic
conda install -y -c conda-forge -c bioconda gatk4
conda install -y -c conda-forge -c bioconda fastqc
# Help conda resolving Python "import" 
conda update --all

# RSTUDIO
mkdir -p /usr/local/lib/R/etc/ /usr/lib/R/etc/
echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" | tee /usr/local/lib/R/etc/Rprofile.site | tee /usr/lib/R/etc/Rprofile.site
R -e 'install.packages("remotes")'
# Update apt-get
Rscript -e 'install.packages("remotes", version = "2.4.2")'
Rscript -e 'remotes::install_cran("rmarkdown",upgrade="never", version = "2.19")'
Rscript -e 'remotes::install_cran("knitr",upgrade="never", version = "1.41")'
Rscript -e 'remotes::install_cran("tidyverse",upgrade="never", version = "1.3.2")'
Rscript -e 'remotes::install_cran("plotly",upgrade="never", version = "4.10.1")'
Rscript -e 'remotes::install_cran("RColorBrewer",upgrade="never", version = "1.1-3")'
Rscript -e 'remotes::install_cran("data.table",upgrade="never", version = "1.14.6")'
Rscript -e 'remotes::install_cran("viridis",upgrade="never", version = "0.6.2")'
Rscript -e 'remotes::install_cran("DT",upgrade="never", version = "0.26")'

%runscript
exec /bin/bash "$@"
%startscript
exec /bin/bash "$@"

