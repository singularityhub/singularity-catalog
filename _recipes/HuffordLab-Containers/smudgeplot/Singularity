Bootstrap: docker
From: ubuntu:18.04

%environment
   export DEBIAN_FRONTEND=noninteractive
   export DEBCONF_NONINTERACTIVE_SEEN=true


%labels
   Author Arun Seetharam
   Version v1
   Maintainer arnstrm@iastate.edu

%help
   This is a container for the smudgeplot (include compiled KMC)

%test
   which python3
   which smudgeplot.py
   which kmc

%post
   apt-get update
   apt-get install -y build-essential wget curl git autoconf
   echo "America/Chicago" > /etc/timezone
   DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
   apt-get install -y gcc g++ make
   apt-get install -y zlib1g-dev libgomp1 libgomp1 libpam-systemd-
   apt-get install -y libcurl4-gnutls-dev libxml2-dev libssl-dev libbz2-dev
   apt-get install -y gfortran
   apt-get install -y python3 python3-pip
   apt-get install -y r-base
   pip3 install "pybind11[global]"
   pip3 install numpy
   pip3 install scipy
# instll KMC
   cd opt/
   git clone https://github.com/tbenavi1/KMC.git
   cd KMC/
   make
   mv bin/* /usr/bin/
# install smudgeplot
   cd /opt/
   git clone https://github.com/KamilSJaron/smudgeplot

   cd smudgeplot/
   R -e "install.packages('devtools')"
   R -e "install.packages('viridis')"
   R -e "install.packages('argparse')"
   Rscript install.R
   install -C exec/smudgeplot.py /usr/local/bin
   install -C exec/smudgeplot_plot.R /usr/local/bin
