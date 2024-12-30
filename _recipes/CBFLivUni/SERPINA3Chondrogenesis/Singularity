Bootstrap: docker
From: eddelbuettel/r2u:jammy

%files
    ./install/* install/
    ./runAnalysis.R ./

%post
apt-get update &&
apt-get -y install --no-install-recommends git bzip2 libglpk-dev libjpeg-dev libz-dev libxt-dev libtiff5-dev libbz2-dev libfontconfig1-dev libssl-dev cmake pandoc && rm -rf /var/lib/apt/lists/*
       
#install the R libraries needed
Rscript ./install/installRLibs.R

#reduce the image size by removing tools not needed to run the analysis
apt-get purge -y --auto-remove gcc git build-essential


%runscript
Rscript runAnalysis.R


