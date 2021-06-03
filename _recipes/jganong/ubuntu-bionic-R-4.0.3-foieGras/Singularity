Bootstrap:docker  
From:rocker/r-ubuntu:20.04

%labels
MAINTAINER jganong@stanford.edu

%environment
# without the TERM setting, it does not backspace, actually it does but does not show it which is worse
export TERM=xterm-256color

%runscript
exec /usr/bin/R "$@"  

%post  
apt update
apt install -y r-cran-ncdf4
apt install -y r-cran-rgeos
apt install -y r-cran-foiegras

