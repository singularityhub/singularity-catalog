Bootstrap: docker
From: mambaorg/micromamba:latest

%labels
    Author fabian.rost@tu-dresden.de
    Organisation DcGC
    Version latest

%help
  Container for amplicov

%environment
  export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

%post
  micromamba install -n base -y -c bioconda -c conda-forge -c defaults --quiet amplicon_coverage_plot 
  micromamba clean --all --yes

%runscript
  amplicov "$@"
