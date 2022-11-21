bootstrap: docker
from: frolvlad/alpine-python3


%environment
  export PSITURK_GLOBAL_CONFIG_LOCATION=$HOME
  source /venv/bin/activate


%runscript
  cd psiturk
  bash -c "$@"


%post
  apk add --no-cache bash build-base linux-headers git procps \
      python3-dev libffi-dev openssl-dev ncurses-dev
  /usr/bin/python3 -m pip install --upgrade pip
  pip install virtualenv
  cd /
  virtualenv /venv
  source /venv/bin/activate
  /venv/bin/python -m pip install --upgrade pip
  /venv/bin/python -m pip install psiturk python-Levenshtein
