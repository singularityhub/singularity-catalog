Bootstrap: docker
From: jupyter/datascience-notebook:latest

%help
  Extended jupyter/datascience-notebook with packages for CodeRefinery workshop.

  How to start Jupyter Lab IDE:
    - with default options:                  ./coderefinery.sif
    - with custom options:                   ./coderefinery.sif --port=9876 --no-browser
    - with bind mount(s):                    singularity run -B /my/custom/path coderefinery.sif
    - with bind mount(s) and custom options: singularity run -B /my/custom/path coderefinery.sif --port=9876 --no-browser

%labels
  Author francesco.tabaro@tuni.fi
  Version 0.1.1

%post
  BUILDDATE=$(date -I)
  VERSION="0.1.1"
  echo "export BUILDDATE=\"${BUILDDATE}\"" >> $SINGULARITY_ENVIRONMENT
  echo "export VERSION=\"${VERSION}\"" >> $SINGULARITY_ENVIRONMENT
  PATH=/opt/conda/bin:$PATH && \
  apt-get update && apt-get install -y -q vim zip curl && \
  conda install --quiet --yes sphinx sphinx_rtd_theme pytest pycodestyle && \
  conda install --quiet --yes -c conda-forge jupyterlab-git nbdime ipywidgets && \
  conda install --quiet --yes -c conda-forge -c bioconda snakemake-minimal && \
  conda clean --all -f && \
  pip install jupyterlab_github && \
  jupyter lab build && \
  jupyter labextension install @jupyterlab/github

%environment
  export PATH=/opt/conda/bin:$PATH
  
%runscript
  echo "CodeRefinery 2020 Singularity container v$VERSION-$BUILDDATE"
  echo "Starting Jupyter Lab..."
  exec jupyter lab $@
