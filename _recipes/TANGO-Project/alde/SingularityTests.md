# Using Singularity

&copy; Atos Spain S.A. 2016

Application Lifecycle Deployment Engine (ALDE) is a component of the European Project TANGO (http://tango-project.eu ).

## [Install on Linux](http://singularity.lbl.gov/install-linux)

### Prerequisites in Ubuntu 16.04

To be able to install this tool, please, make sure the following packages are installed first:

```bash
$ sudo apt-get update
...
$ sudo apt-get install gcc python make
```

### Installation

```bash
VERSION=2.3.1
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvfz singularity-2.3.1.tar.gz
cd singularity-2.3.1 
./configure
make
sudo make install
```

## Custom bootstrap / scripts (using a Docker image)

1. [Docker](https://www.docker.com/) images can be used by Singularity (*.def* files)

2. Example script (*.def* file):

```bash
# This creates the base/core image as defined. You can swap out the base OS simply by changing these below lines and rebuilding.
BootStrap: docker
From: ubuntu:latest

# What to do when the container is run
%runscript
  echo "[runscript]"
  echo "[-] Executing 'cd myapp'..."
  exec /home/myapp/myapp

%setup
  echo "[setup] - ubuntu:latest -"
  mkdir -p $SINGULARITY_ROOTFS/home/myapp
  cp ./main.c $SINGULARITY_ROOTFS/home/myapp

# Files that are included from the host
# %files

# After the base OS is built, these commands are run inside the container
%post
  echo "[post]"
  apt-get update -y
  echo "[-] Installing gcc tools..."
  apt-get install build-essential -y
  echo "[-] Executing 'ls -l'..."
  ls -l
  cd /home/myapp
  echo "[-] Compiling program..."
  gcc -o myapp main.c
  ls -l
```

3. Launch image
- create image

```bash
sudo singularity create test.img
```

- bootstrap

```bash
sudo singularity bootstrap test.img docker.def
```

- run

```bash
sudo singularity run test.img
```
