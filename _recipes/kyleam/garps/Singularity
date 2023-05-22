Bootstrap:docker
From:neurodebian:stretch


%labels
Maintainer Kyle Meyer
Version v1.0


%help
This container provides an analysis environment that includes -- among
other things -- git-annex, RStan, Python 3, and Snakemake.  It
executes Snakemake by default.


%post
apt-get -y update
apt-get -y install eatmydata

eatmydata apt-get install -y locales

# Based on rocker.
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8

eatmydata apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev libssl-dev zlib1g-dev fonts-texgyre \
  gcc g++ gfortran libblas-dev liblapack-dev \
  make git git-annex-standalone pandoc \
  python3-docopt python3-pytest \
  r-base-core r-recommended r-cran-littler \
  dos2unix snakemake

apt-get clean
rm -rf /var/lib/apt/lists/

# Based on https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Mac-or-Linux
mkdir -p $HOME/.R
cat >$HOME/.R/Makevars <<EOF
CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function  -Wno-macro-redefined
CXXFLAGS+=-flto -Wno-unused-local-typedefs
CXXFLAGS += -Wno-ignored-attributes -Wno-deprecated-declarations
EOF

# Based on rocker.
echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"), download.file.method = "libcurl")' >>/etc/R/Rprofile.site
echo 'source("/etc/R/Rprofile.site")' >>/etc/littler.r
ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r
ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r

install.r docopt
install2.r --error \
  devtools hexbin testthat knitr rmarkdown ggplot2 \
  forcats lubridate readr tidyr directlabels rstan bayesplot

mkdir -p /mnt/scratch


%environments
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_ALL=en_US.UTF-8
export LANG LANGUAGE LC_ALL


%runscript
/usr/bin/snakemake "$@"
