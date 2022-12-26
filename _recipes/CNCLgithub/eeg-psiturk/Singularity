bootstrap: docker
from: debian:stable

%runscript
  cd psiturk
  bash -c "source activate /conda_env && psiturk $@"

%post
  apt update
  apt install python3-pip python3-dev libncurses-dev python-pymysql \ python-sqlalchemy libmysqlclient-dev
  pip install git+https://github.com/NYUCCL/psiturk.git python-Levenshtein

