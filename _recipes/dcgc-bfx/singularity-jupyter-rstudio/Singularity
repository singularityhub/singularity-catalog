Bootstrap: shub
From: dcgc-bfx/dcgc-base-conda:0.1.1

%labels
  Author fabian.rost@tu-dresden.de
  Organisation DcGC
  Version latest

%help
  Start jupyter lab:
    singularity run --writable-tmpfs --app jupyter library://fabianrost84/dcgc/single-cell.sif

  Start rstudio server listening on port 8787:
    singularity run --writable-tmpfs --app rserver library://fabianrost84/dcgc/single-cell.sif 8787

%files
  files/jupyter_notebook_config.json /opt/conda/etc/jupyter/
  files/rserver.conf /etc/rstudio/rserver.conf

%environment
  DEBIAN_FRONTEND=noninteractive

%post
  chmod -R a+w /opt
  export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

  mamba install --quiet --yes \
    ipykernel \
    jupyter_nbextensions_configurator \
    jupyterlab \
    nodejs \
    r-irkernel

  # clean conda cache
  mamba clean -ai --quiet --yes

  # jupyterlab extensions
  jupyter labextension install "@jupyterlab/toc"

  # rstudio server
  apt-get update --fix-missing -q
  apt-get install -y -q \
    gdebi-core \
    uuid

  wget --no-verbose https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb
  gdebi -q -n rstudio-server-1.4.1106-amd64.deb
  rm rstudio-server-1.4.1106-amd64.deb
  chmod -R a+rw /var/lib/rstudio-server

  apt-get clean -q
  rm -rf /var/lib/apt/lists/*

  # for running rstudio server with conda R
  git clone https://github.com/grst/rstudio-server-conda.git

  chmod -R a+w /opt

####################
## rstudio server ##
####################

%apprun rserver
  bash <<-EOF
	source activate /opt/conda
	/rstudio-server-conda/start_rstudio_server.sh "${@}"
EOF

#################
## jupyter lab ##
#################

%apprun jupyter
  bash <<-EOF
	source activate /opt/conda
	jupyter lab --no-browser "${@}"
EOF
