Bootstrap: docker
From: r-base:3.6.3
Stage: spython-base

%files
renv.lock
.Renviron

%post

# Install system dependencies for R
apt-get update -qq && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
apt-transport-https \
build-essential \
curl \
gfortran \
libatlas-base-dev \
libbz2-dev \
libcairo2-dev \
libicu-dev \
liblzma-dev \
libpango-1.0-0 \
libpangocairo-1.0-0 \
libpcre3-dev \
libtcl8.6 \
libtiff5 \
libtk8.6 \
libx11-6 \
libxt6 \
libxt-dev \
locales \
tzdata \
libglib2.0-dev \
zlib1g-dev \
meson \
pkg-config \
gtk-doc-tools \
libfreetype6-dev \
libpng-dev \
libtiff5-dev \
libjpeg-dev \
libharfbuzz-dev \
libfribidi-dev \
libbz2-dev \
libgsl0-dev \
gsl-bin \
libgit2-dev
        
# Install system dependencies for the tidyverse R packages
apt-get install -y \
make \
libcurl4-openssl-dev \
libssl-dev \
pandoc \
libxml2-dev
    
# Install Python
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
python3.9-dev \
python3-tk \
python3-pip \
python3-distutils \
python3-setuptools

# Install Python packages
pip install MACS2

# Install GSL
#RUN wget https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
#RUN tar -zxvf gsl-2.6.tar.gz; cd gsl-2.6; ./configure && make && make install


# Install R packages
R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RENV_VERSION=0.12.3-71
R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

chmod -R 777 /usr

# pull in an renv manifest file and restore it to load pacakges
R --vanilla -s -e 'renv::consent(provided = TRUE); renv::restore(prompt = FALSE)'


%runscript
exec /bin/bash "$@"
%startscript
exec /bin/bash "$@"
