# Singularityfile bootstrap file
Bootstrap: docker
From: alpine:3.6

%labels
AUTHOR ludd@bioinformatics.dtu.dk
Version 1.0

# 'setup' section is executed on the host system outside of the container after the base OS has been installed!
%setup
mkdir $SINGULARITY_ROOTFS/app

# Copy files from your host system into the container!
%files
app/*   /app

# 'environment' variables are sourced at runtime and not at build time!
%environment
MAGIC=abbracadabbra
export MAGIC

# 'post' section is where you can install, and configure your container.
%post
# OS Update & Upgrade
apk update && apk upgrade

# Install packages
apk add \
  git \
  python \
  py-pip

# Execute script as a global program
ln -s /app/main.py /usr/local/bin/fsa-analyzer
chmod +x /usr/local/bin/fsa-analyzer

# Executed on 'singularity run img'
%runscript
echo "The runscript is the containers default runtime command!"
