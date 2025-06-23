Bootstrap: docker
From: {{ ROCKER_BASE }}

%arguments
  ROCKER_BASE=rocker/tidyverse:latest
  BLIMP_BINARY_URL=https://blimp-stats.github.io/linux/src/blimp_binary.tar.gz
  RBLIMP_GITHUB_REPO=blimp-stats/rblimp@main

%post
  set -ex
  wget -qO - "{{ BLIMP_BINARY_URL }}" | tar -xzvf - -C /usr/local/bin/ --strip-components=1 blimp_binary/blimp && \
  installGithub.r "{{ RBLIMP_GITHUB_REPO }}" && \
  blimp --changelog | grep -m1 'Version' && \
  R -q --vanilla -e 'rblimp::detect_blimp()' && \
  echo 'Success!'

