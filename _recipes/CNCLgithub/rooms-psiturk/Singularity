bootstrap: docker
from: frolvlad/alpine-miniconda2


%environment
  export PATH=$PATH:/opt/conda/bin
  export PSITURK_GLOBAL_CONFIG_LOCATION=$HOME

%runscript
  cd psiturk
  bash -c "source activate /conda_env && psiturk $@"

%post
  apk add --no-cache bash build-base linux-headers git procps
  /opt/conda/bin/conda create --yes -p /conda_env python=2.7
  export PATH=$PATH:/opt/conda/bin
  bash -c 'source activate /conda_env && pip install psiturk python-Levenshtein'
