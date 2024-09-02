Bootstrap: docker
From: ubuntu:18.10

%post
#Set timezone for tzdata
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
echo "tzdata tzdata/Areas select Europe" >> preseed.txt
echo "tzdata tzdata/Zones/Europe select London" >> preseed.txt
apt-get -y update && apt-get install -y apt-utils
apt-get install -y build-essential

#Set preseed options
debconf-set-selections preseed.txt
apt-get install -y tzdata

apt-get install -y wget
apt-get install -y ed
apt-get install -y nano
apt-get install -y git-all
apt-get install -y software-properties-common #required for apt-add-repository
apt-get -y update
apt-get -y install openssl-dev
apt-get -y install libcurl4-openssl-dev libxml2-dev

#Set correct locale for R
apt-get -y update && apt-get install -y locales
locale-gen en_GB.UTF-8

#Install R
echo "deb https://cloud.r-project.org/bin/linux/ubuntu cosmic-cran35/" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

apt-get -y update
apt-get install -y r-base
apt-get install -y r-base-dev

#Install any prerequisite system level libraries for R packages
#Check the relevant vignette documents on CRAN for information
#sf needs libudunits2-dev
#See vignette: https://cran.r-project.org/web/packages/sf/sf.pdf
apt-get install -y libudunits2-dev

#gdtools (prereq of rgdal) requires Cairo
#rgdal needs libgdal and proj4
apt-get install -y libcairo2-dev
apt-get install -y libgdal-dev
apt-get install -y proj-bin

#sf requires geos
apt-get install -y libgeos-dev

#Install R packages
Rscript -e 'install.packages("rgdal")'
Rscript -e 'install.packages("tmap")'
Rscript -e 'install.packages("sf")'

Rscript -e 'install.packages("GISTools")'
Rscript -e 'install.packages("sp")'
Rscript -e 'install.packages("gstat")'
Rscript -e 'install.packages("raster")'
Rscript -e 'install.packages("deldir")'
Rscript -e 'install.packages("pycno")'
Rscript -e 'install.packages("rtop")'



Rscript -e 'install.packages("scales")'
Rscript -e 'install.packages("ggplot2")'
Rscript -e 'install.packages("tbart")'
Rscript -e 'install.packages("automap")'
Rscript -e 'install.packages("geosphere")'


Rscript -e 'install.packages("tidyverse")'
Rscript -e 'install.packages("RCurl")'
Rscript -e 'install.packages("rvest")'
Rscript -e 'install.packages("jsonlite")'
Rscript -e 'install.packages("OpenStreetMap")'
Rscript -e 'install.packages("grid")'


Rscript -e 'install.packages("osmdata")'
Rscript -e 'install.packages("repmis")'
Rscript -e 'install.packages("gclus")'
Rscript -e 'install.packages("stringr")'

#Create stub directory for /nobackup
mkdir -p /nobackup

%environment
#set environment variables for correct R locale
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
