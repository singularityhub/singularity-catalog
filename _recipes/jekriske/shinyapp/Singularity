Bootstrap: shub
From: jekriske/r-base

%labels
  Maintainer Jeff Kriske

%environment
  source /opt/rh/devtoolset-7/enable
  export SHINY_PORT=31337

%help
  This will run a simple shiny app from the gallery example at
  https://github.com/rstudio/shiny-examples/tree/master/050-kmeans-example

%runscript
  cd /myshinyapp
  exec R -e "options(browser='firefox');shiny::runApp(host='0.0.0.0', port=$SHINY_PORT, launch.browser=TRUE)"

%post
  source /opt/rh/devtoolset-7/enable
  yum update -y
  yum install -y firefox wget
  mkdir myshinyapp && cd myshinyapp
  wget https://raw.githubusercontent.com/rstudio/shiny-examples/master/050-kmeans-example/server.R
  wget https://raw.githubusercontent.com/rstudio/shiny-examples/master/050-kmeans-example/ui.R
  Rscript -e "install.packages('packrat', repos='http://cran.rstudio.com')"
  Rscript -e "packrat::init();install.packages('shiny', repos='http://cran.rstudio.com')"
  yum clean all && rm -rf /var/cache/yum
