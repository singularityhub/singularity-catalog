Bootstrap: docker
From: thomaschln/r-devtools

%environment
  PATH=$PATH:/opt/man_qq_annotate

%post
  apt-get update
  apt-get install -y git libxtst6 libxt6
  cd /opt
  git clone https://github.com/hmgu-itg/man_qq_annotate.git
  cd man_qq_annotate
  Rscript -e 'library(devtools); install()'


%runscript
  exec manqq_cli "$@"
