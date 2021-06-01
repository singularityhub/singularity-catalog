Bootstrap: docker
From: thomaschln/r-devtools

%environment
  PATH=$PATH:/opt/man_qq_annotate

%post
  apt install -y git libxtst6
  cd /opt
  git clone https://github.com/hmgu-itg/man_qq_annotate.git
  cd man_qq_annotate
  R -e 'library(devtools); install()'


%runscript
  exec run_manqq.R "$@"
