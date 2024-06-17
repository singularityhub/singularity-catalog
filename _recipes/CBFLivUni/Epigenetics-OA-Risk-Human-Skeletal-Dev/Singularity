Bootstrap: docker
From: rocker/rstudio:4.2.2

%files
    ./install/* install/

%post
apt-get update &&
apt-get -y install --no-install-recommends git bzip2 libglpk-dev libjpeg-dev libz-dev libxt-dev libtiff5-dev libbz2-dev libfontconfig1-dev libssl-dev libgsl-dev libpq-dev tk-dev

wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.0.37/quarto-1.0.37-linux-amd64.deb
dpkg -i quarto-1.0.37-linux-amd64.deb
rm quarto-1.0.37-linux-amd64.deb
         
#install the R libraries needed
Rscript ./install/installRLibs.R
