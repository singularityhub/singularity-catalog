Bootstrap: docker
From: eddelbuettel/r2u:jammy

%files
    ./install/* install/
    ./runAnalysis.R ./

%post
apt-get update &&
apt-get -y install --no-install-recommends git bzip2 libglpk-dev libjpeg-dev libz-dev libxt-dev libtiff5-dev libbz2-dev libfontconfig1-dev libssl-dev cmake && rm -rf /var/lib/apt/lists/*

wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb
dpkg -i quarto-1.3.450-linux-amd64.deb
rm quarto-1.3.450-linux-amd64.deb
         
#install the R libraries needed
Rscript ./install/install.R

#reduce the image size by removing tools not needed to run the analysis
apt-get purge -y --auto-remove gcc git build-essential


%runscript
Rscript runAnalysis.R


