Bootstrap: docker
From: apache/spark@sha256:a1dd2487a97fb5e35c5a5b409e830b501a92919029c62f9a559b13c4f5c50f63
Stage: spython-base

%post

# Needed for interacting with Slurm
useradd slurm
apt-get update
apt-get install libmunge-dev libmunge2 munge
PATH="${PATH}:/opt/slurm/bin"
%environment
export PATH="${PATH}:/opt/slurm/bin"
%runscript
exec /bin/bash "$@"
%startscript
exec /bin/bash "$@"