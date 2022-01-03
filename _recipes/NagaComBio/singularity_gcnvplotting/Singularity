Bootstrap: docker

From: rocker/tidyverse:3.5.1

%files
  install_script.R
  samplot_env.yml

%environment
  CONDA_INSTALL_PATH="/usr/local/miniconda3"
  CONDA_BIN_PATH="/usr/local/miniconda3/bin"
  CONDA_ENV_PATH="/usr/local/miniconda3/envs/samplot/bin"

%post
  echo "Installing R packages"
  /usr/local/bin/Rscript install_script.R

  echo "Installing miniconda"
  apt-get update && apt-get -y install wget
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  chmod +x Miniconda3-latest-Linux-x86_64.sh
  CONDA_INSTALL_PATH="/usr/local/miniconda3"
  ./Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_INSTALL_PATH
  export PATH="/usr/local/miniconda3/bin:$PATH"
  conda create -n samplot -c anaconda -c bioconda -c conda-forge --file samplot_env.yml
  echo "PATH=/usr/local/miniconda3/envs/samplot/bin:$PATH" >> /usr/local/lib/R/etc/Renviron

  # The conda env will be activated by default
  echo ". /usr/local/miniconda3/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT
  echo "conda activate samplot" >> $SINGULARITY_ENVIRONMENT

%runscript

%startscript
