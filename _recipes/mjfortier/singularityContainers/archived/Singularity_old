Bootstrap:docker
From:ubuntu:latest

%labels
  CREATOR Matthew Fortier
  PURPOSE To provide containerization of CLASSIC functionality
  VERSION 0.1

%setup
  cp -R /home/matt/Documents/Work/singularityContainers/para_netcdf_hdf-4.6.3 $SINGULARITY_ROOTFS


%post
  apt update
  apt install ca-certificates -y -f -m
  cat /etc/apt/sources.list
  echo "deb [trusted=yes] https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee -a /etc/apt/sources.list
  apt update
  apt install r-base-dev -y -f -m

  apt install vim make curl build-essential git libnetcdff-dev git zip unzip python3 m4 gfortran netcdf-bin nano zlib1g mpich doxygen gedit python3 python3-pip nco ncview libopenmpi-dev libgeos-dev libgdal-dev libproj-dev pandoc poppler-utils texlive-latex-base -y -f -m


  R --slave -e 'install.packages(c("classInt", "doParallel", "foreach", "latex2exp", "ncdf4", "parallel", "raster", "rgeos", "scico", "sp", "spatial.tools", "stats", "utils", "viridis", "xtable", "knitr", "rmarkdown", "testthat", "devtools"), repos="cran.rstudio.com")'

  pip3 install numpy
  pip3 install cython
  pip3 install pyyaml xarray pandas seaborn matplotlib cartopy statistics sklearn netcdf4

  mkdir -p /packages
  curl -o /packages/cdo-1.9.6.tar.gz "https://code.mpimet.mpg.de/attachments/download/19299/cdo-1.9.6.tar.gz"
  cd /packages
  tar -xzvf cdo-1.9.6.tar.gz cdo-1.9.6/
  rm cdo-1.9.6.tar.gz
  cd cdo-1.9.6
  ./configure
  make && make install

  cd /para_netcdf_hdf-4.6.3/setup
  ./setup_netcdf.sh
  chmod 777 -R /para_netcdf_hdf-4.6.3
  cd /para_netcdf_hdf-4.6.3
  ./dobuild.mpi
  echo 'export LD_LIBRARY_PATH=/para_netcdf_hdf-4.6.3/MPI/lib$LD_LIBRARY_PATH' >>$SINGULARITY_ENVIRONMENT


