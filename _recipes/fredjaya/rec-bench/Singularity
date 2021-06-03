Bootstrap: docker
From: nfcore/base

%labels
  Author Fred Jaya <fredjaya1@gmail.com>
  Version 0.1.0

%environment
  export PATH=/opt/conda/envs/fredjaya-rec-bench-0.1.0/bin:$PATH

%files
  environment.yml /

%post
  /opt/conda/bin/conda env create -f /environment.yml
  /opt/conda/bin/conda clean -a

%test
  Profile 2&>1 | grep "Usage"
